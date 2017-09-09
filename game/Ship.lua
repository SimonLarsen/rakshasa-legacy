local PlayerBullet = require("game.PlayerBullet")
local Explosion = require("game.Explosion")
local Flash = require("game.Flash")

local Ship = class("game.Ship", prox.Entity)

Ship.static.SIDE_LEFT = 1
Ship.static.SIDE_RIGHT = 2

local FAST_ACCELERATION = 2400
local SLOW_ACCELERATION = 2000
local DECELLERATION = 1200
local SLOW_MAX_SPEED = 150
local FAST_MAX_SPEED = 270
local RETRACT_SPEED = 900

local BULLET_COOLDOWN = 0.1
local DEADZONE_THRESHOLD = 0.20

local ENTER_TIME = 1.0

Ship.static.STATE_ENTER      = 1
Ship.static.STATE_ACTIVE     = 2
Ship.static.STATE_RETRACTING = 3
Ship.static.STATE_DEAD       = 4

function Ship:enter(side)
	self:setName("ship")
	self.y = settings.screen_height + 50
	self.z = 0
	self.xspeed = 0
	self.yspeed = 0
	self.xmove = 0
	self.ymove = 0
	self.side = side
	self.shooting = 0
	self.cooldown = 0
	self.direction = 0
	self.state = Ship.static.STATE_ENTER
	self.flash = 0
	self.controller = self:getScene():find("controller")

	self:setCollider(prox.BoxCollider(18, 34))
	self.gear_sprite = prox.Sprite("data/images/ship_gear.png", 19, 19)

	self:setRenderer(prox.MultiRenderer())
	self:getRenderer():addRenderer(self.gear_sprite, 0, 1)

	self.exhaust_renderer = prox.Animator("data/animators/ship_exhaust.lua")
	self:getRenderer():addRenderer(self.exhaust_renderer, 0, 19)

	self.ship_renderer = prox.Animator("data/animators/ship.lua")
	self:getRenderer():addRenderer(self.ship_renderer)

	if self.side == Ship.static.SIDE_LEFT then
		self.x = settings.screen_width/2 - 40
	else
		self.x = settings.screen_width/2 + 40
		self.ship_renderer:setScale(-1, 1)
	end
	self:getRenderer():addRenderer(self.animator)

	prox.timer.tween(ENTER_TIME, self, {y = settings.screen_height-80}, "out-quad",
		function()
			self.state = Ship.static.STATE_ACTIVE
		end
	)

	self.white_shader = prox.resources.getShader("data/shaders/whiteout.glsl")

	self.sfx_laser = prox.resources.getSound("data/sounds/laser2.wav")
	for i,v in ipairs(self.sfx_laser) do
		v:setVolume(0.8)
	end
end

function Ship:update(dt, rt)
	self.cooldown = self.cooldown - dt
	self.shooting = self.shooting - dt

	if self.purity_ball and not self.purity_ball:isAlive() then
		self.purity_ball = nil
	end

	if self.state == Ship.static.STATE_ACTIVE then
		-- Move ship
		local acceleration = self.shooting > 0 and SLOW_ACCELERATION or FAST_ACCELERATION
		local max_speed = self.shooting > 0 and SLOW_MAX_SPEED or FAST_MAX_SPEED

		self.xspeed = self.xspeed + acceleration * dt * self.xmove
		self.yspeed = self.yspeed + acceleration * dt * self.ymove

		local speed = math.sqrt(self.xspeed^2 + self.yspeed^2)
		if speed > max_speed then
			self.xspeed = self.xspeed / speed * max_speed
			self.yspeed = self.yspeed / speed * max_speed
		end

		self.x = prox.math.cap(self.x + self.xspeed * dt, 10, settings.screen_width-10)
		self.y = prox.math.cap(self.y + self.yspeed * dt, 10, settings.screen_height-10)

		self.xspeed = prox.math.movetowards(self.xspeed, 0, DECELLERATION*dt)
		self.yspeed = prox.math.movetowards(self.yspeed, 0, DECELLERATION*dt)
	elseif self.state == Ship.static.STATE_RETRACTING then
		self.x = prox.math.movetowards(self.x, self.destx, math.abs(self.xspeed)*dt)
		self.y = prox.math.movetowards(self.y, self.desty, math.abs(self.yspeed)*dt)

		local xdist = self.destx - self.x
		local ydist = self.desty - self.y
		if xdist^2 + ydist^2 < 50^2 then
			self.state = Ship.static.STATE_ACTIVE
		end
	end

	self:getRenderer():setShader(self.flash > 0 and self.white_shader or nil)
	self.flash = self.flash - dt

	self.exhaust_renderer:setProperty("shooting", self.shooting > 0)
	self.ship_renderer:setProperty("shooting", self.shooting > 0)
end

function Ship:shoot()
	self.shooting = 0.1
	if self.cooldown <= 0 then
		self:getScene():add(PlayerBullet(self.x, self.y-32, 1.5*math.pi, PlayerBullet.static.TYPE_SUPER))
		self:getScene():add(Flash(self.x, self.y-24, 2))
		self.sfx_laser:play()
		self.cooldown = BULLET_COOLDOWN
		self:getScene():find("painting"):addSplatter(self.x, self.y, 2, true)
	end
end

function Ship:retract(destx, desty)
	self.state = Ship.static.STATE_RETRACTING
	self.destx = destx
	self.desty = desty

	local xdist = destx - self.x
	local ydist = desty - self.y
	local dist = math.sqrt(xdist^2 + ydist^2)
	self.xspeed = xdist / dist * RETRACT_SPEED
	self.yspeed = ydist / dist * RETRACT_SPEED
end

function Ship:setMovement(xmove, ymove)
	self.xmove, self.ymove = xmove, ymove
end

function Ship:getGearSprite()
	return self.gear_sprite
end

function Ship:setDirection(direction)
	self.gear_sprite:setRotation(direction)
	self.direction = direction
end

function Ship:setSide(side)
	self.side = side
	if self.side == Ship.static.SIDE_LEFT then
		self.ship_renderer:setScale(1, 1)
	else
		self.ship_renderer:setScale(-1, 1)
	end
end

function Ship:onCollide(o, dt, rt)
	if o:getName() == "gem" then
		self.controller:addGems(o:getGems())
		self.flash = 0.05
		o:pickup()
	elseif o:getName() == "player_bullet" then
		o:kill(true)
	end
end

function Ship:kill()
	self:getScene():add(Explosion(self.x, self.y, Explosion.static.SIZE_LARGE))
	self.state = Ship.static.STATE_DEAD
end

return Ship

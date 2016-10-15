local shaders = require("shaders")
local Bullet = require("game.Bullet")
local Explosion = require("game.Explosion")
local Flash = require("game.Flash")
local GemPickup = require("game.GemPickup")

local Ship = class("game.Ship", prox.Entity)

Ship.static.SIDE_LEFT = 1
Ship.static.SIDE_RIGHT = 2

local FAST_ACCELERATION = 2300
local SLOW_ACCELERATION = 2000
local DECELLERATION = 1200
local SLOW_MAX_SPEED = 150
local FAST_MAX_SPEED = 250

local BULLET_COOLDOWN = 0.12
local DEADZONE_THRESHOLD = 0.20

local ENTER_TIME = 1.0
local POWER_TRIGGER_TIME = 0.1

Ship.static.STATE_ENTER  = 1
Ship.static.STATE_ACTIVE = 2
Ship.static.STATE_DEAD   = 3

local BULLET_COOLDOWN = {
	0.1, 0.13, 0.16
}

function Ship:enter(side)
	self:setName("ship")
	self.y = settings.screen_height + 50
	self.z = 0
	self.xspeed = 0
	self.yspeed = 0
	self.xmove = 0
	self.ymove = 0
	self.side = side
	self.cooldown = 0
	self.direction = 0
	self.state = Ship.static.STATE_ENTER
	self.power_level = 1
	self.flash = 0
	self.power_trigger = 0

	self:setCollider(prox.BoxCollider(18, 34))
	self.gear_sprite = prox.Sprite("data/images/ship_gear.png", 19, 19)

	self:setRenderer(prox.MultiRenderer())
	self:getRenderer():addRenderer(self.gear_sprite, 0, 1)

	self.animator_left = prox.Animator("data/animators/ship_left.lua")
	self.animator_right = prox.Animator("data/animators/ship_right.lua")

	if self.side == Ship.static.SIDE_LEFT then
		self.x = settings.screen_width/2 - 40
		self.animator = self.animator_left
	else
		self.x = settings.screen_width/2 + 40
		self.animator = self.animator_right
	end
	self:getRenderer():addRenderer(self.animator)

	prox.timer.tween(ENTER_TIME, self, {y = settings.screen_height-80}, "out-quad",
		function()
			self.state = Ship.static.STATE_ACTIVE
		end
	)

	self.white_shader = shaders.getShader("data/shaders/whiteout.lua")

	self.sfx_blip = prox.resources.getSound("data/sounds/blip.wav")
	self.sfx_blip:setVolume(0.5)
	self.sfx_laser = {
		[1] = prox.resources.getSound("data/sounds/laser1.wav"),
		[2] = prox.resources.getSound("data/sounds/laser2.wav"),
		[3] = prox.resources.getSound("data/sounds/laser3.wav")
	}
	for i,v in ipairs(self.sfx_laser) do
		v:setVolume(0.8)
	end
end

function Ship:update(dt, rt)
	self.power_trigger = self.power_trigger - dt
	self.cooldown = self.cooldown - dt

	if self.state == Ship.static.STATE_ACTIVE then
		-- Move ship
		local shooting = self.cooldown > 0
		local acceleration = shooting and SLOW_ACCELERATION or FAST_ACCELERATION
		local max_speed = shooting and SLOW_MAX_SPEED or FAST_MAX_SPEED

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
	end

	self:getRenderer():setShader(self.flash > 0 and self.white_shader or nil)
	self.flash = self.flash - dt
end

function Ship:shoot()
	if self.cooldown <= 0 then
		if self.power_level == 1 then
			self:getScene():add(Bullet(self.x, self.y-20, 1.5*math.pi, Bullet.static.TYPE_PLAYER_BULLET))
		elseif self.power_level == 2 then
			self:getScene():add(Bullet(self.x, self.y-32, 1.5*math.pi, Bullet.static.TYPE_PLAYER_SUPER))
		elseif self.power_level == 3 then
			self:getScene():add(Bullet(self.x, self.y-32, 1.5*math.pi, Bullet.static.TYPE_PLAYER_ULTRA))
		else
			error("Player power levels must be >= 1 and <= 3.")
		end
		self:getScene():add(Flash(self.x, self.y-24, 2))
		self.sfx_laser[self.power_level]:play()
		self.cooldown = BULLET_COOLDOWN[self.power_level]
	end
end

function Ship:setMovement(xmove, ymove)
	self.xmove, self.ymove = xmove, ymove
end

function Ship:triggerPower()
	self.power_trigger = POWER_TRIGGER_TIME
end

function Ship:powerTriggered()
	return self.power_trigger > 0
end

function Ship:getGearSprite()
	return self.gear_sprite
end

function Ship:setDirection(direction)
	self.gear_sprite:setRotation(direction)
	self.direction = direction
end

function Ship:setPowerLevel(level)
	self.power_level = level
end

function Ship:setSide(side)
	self.side = side
	if self.side == Ship.static.SIDE_LEFT then
		self.animator = self.animator_left
	else
		self.animator = self.animator_right
	end
	self:getRenderer():addRenderer(self.animator)
end

function Ship:onCollide(o, dt, rt)
	if o:getName() == "gem" then
		self:getScene():find("controller"):addGems(o:getGems())
		self:getScene():add(GemPickup(o.x, o.y))
		o:remove()
		self.flash = 0.05
		self.sfx_blip:play()
	elseif o:getName() == "heart" then
		self:getScene():find("controller"):addHeart()
		o:remove()
	elseif o:getName() == "bullet" and o:isPlayerBullet() and not o:isDPS() then
		o:kill()
	end
end

function Ship:kill()
	self:getScene():add(Explosion(self.x, self.y, Explosion.static.SIZE_LARGE))
	self.state = Ship.static.STATE_DEAD
end

return Ship

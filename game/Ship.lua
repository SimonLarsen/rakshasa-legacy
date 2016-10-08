local shaders = require("shaders")
local Bullet = require("game.Bullet")
local Explosion = require("game.Explosion")
local Flash = require("game.Flash")

local Ship = class("game.Ship", prox.Entity)

Ship.static.SIDE_LEFT = 1
Ship.static.SIDE_RIGHT = 2

local FAST_ACCELERATION = 2300
local SLOW_ACCELERATION = 2000
local DECELLERATION = 1200
local SLOW_MAX_SPEED = 150
local FAST_MAX_SPEED = 250

local BULLET_COOLDOWN = 0.12
local SUPER_COOLDOWN = 0.15
local DEADZONE_THRESHOLD = 0.20

local ENTER_TIME = 1.0

Ship.static.STATE_ENTER  = 1
Ship.static.STATE_ACTIVE = 2
Ship.static.STATE_DEAD   = 3

local BULLET_COOLDOWN = {
	0.1, 0.13, 0.16
}

function Ship:enter(side, binding)
	self:setName("ship")
	self.y = settings.screen_height + 50
	self.z = 0
	self.xspeed = 0
	self.yspeed = 0
	self.side = side
	self.cooldown = 0
	self.direction = 0
	self.state = Ship.static.STATE_ENTER
	self.power_level = 1
	self.flash = 0

	self.binding = binding

	self:setCollider(prox.BoxCollider(18, 34))
	self.gear_sprite = prox.Sprite("data/images/ship_gear.png", 19, 19)

	self:setRenderer(prox.MultiRenderer())
	self:getRenderer():addRenderer(self.gear_sprite, 0, 1)

	if side == Ship.static.SIDE_LEFT then
		self.x = settings.screen_width/2 - 40
		self.shoot_action = "leftshoot"
		self.xaxis = "leftx"
		self.yaxis = "lefty"
		self.dead_zone = -math.pi/2
		self.super_zone = math.pi/2
		self.animator = prox.Animator("data/animators/ship_left.lua")
	else
		self.x = settings.screen_width/2 + 40
		self.shoot_action = "rightshoot"
		self.xaxis = "rightx"
		self.yaxis = "righty"
		self.dead_zone = math.pi/2
		self.super_zone = -math.pi/2
		self.animator = prox.Animator("data/animators/ship_right.lua")
	end
	self:getRenderer():addRenderer(self.animator)

	prox.timer.tween(ENTER_TIME, self, {y = settings.screen_height-80}, "out-quad",
		function()
			self.state = Ship.static.STATE_ACTIVE
		end
	)

	self.white_shader = shaders.getShader("data/shaders/whiteout.lua")

	self.sfx_blip = prox.resources.getSound("data/sounds/blip2.wav")
	self.sfx_blip:setVolume(0.5)
	self.sfx_laser = prox.resources.getSound("data/sounds/laser3.wav")
	self.sfx_laser:setVolume(0.8)
end

function Ship:update(dt, rt)
	if self.state == Ship.static.STATE_ACTIVE then
		-- Move ship
		local shooting = self.binding:isDown(self.shoot_action)
		local acceleration = shooting and SLOW_ACCELERATION or FAST_ACCELERATION
		local max_speed = shooting and SLOW_MAX_SPEED or FAST_MAX_SPEED

		self.xspeed = self.xspeed + acceleration * dt * self.binding:getAxis(self.xaxis)
		self.yspeed = self.yspeed + acceleration * dt * self.binding:getAxis(self.yaxis)

		local speed = math.sqrt(self.xspeed^2 + self.yspeed^2)
		if speed > max_speed then
			self.xspeed = self.xspeed / speed * max_speed
			self.yspeed = self.yspeed / speed * max_speed
		end

		self.x = prox.math.cap(self.x + self.xspeed * dt, 10, settings.screen_width-10)
		self.y = prox.math.cap(self.y + self.yspeed * dt, 10, settings.screen_height-10)

		self.xspeed = prox.math.movetowards(self.xspeed, 0, DECELLERATION*dt)
		self.yspeed = prox.math.movetowards(self.yspeed, 0, DECELLERATION*dt)

		-- Shoot
		self.cooldown = self.cooldown - dt

		if self.binding:isDown(self.shoot_action) and self.cooldown <= 0 then
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
			self.sfx_laser:play()
			self.cooldown = BULLET_COOLDOWN[self.power_level]
		end
	end

	self.flash = self.flash - dt
	self:getRenderer():setShader(self.flash > 0 and self.white_shader or nil)
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

function Ship:onCollide(o, dt, rt)
	if o:getName() == "gem" then
		self:getScene():find("controller"):addScore(o:getPoints())
		o:remove()
		self.flash = 0.05
		self.sfx_blip:play()
	elseif o:getName() == "heart" then
		self:getScene():find("controller"):addScore(o:getPoints())
		self:getScene():find("controller"):addLives(1)
		o:remove()
	elseif o:getName() == "bullet" and o:isPlayerBullet() then
		o:kill()
	end
end

function Ship:kill()
	self:getScene():add(Explosion(self.x, self.y, Explosion.static.SIZE_LARGE))
	self.state = Ship.static.STATE_DEAD
end

return Ship

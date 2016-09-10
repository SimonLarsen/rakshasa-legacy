local Bullet = require("game.Bullet")
local Explosion = require("game.Explosion")

local Ship = class("game.Ship", prox.Entity)

Ship.static.SIDE_LEFT = 1
Ship.static.SIDE_RIGHT = 2

local FAST_ACCELERATION = 2300
local SLOW_ACCELERATION = 2000
local DECELLERATION = 1200
local SLOW_MAX_SPEED = 150
local FAST_MAX_SPEED = 250

local BULLET_COOLDOWN = 0.1
local SUPER_COOLDOWN = 0.15
local SUPER_THRESHOLD = 0.1

local ENTER_TIME = 1.0

Ship.static.STATE_ENTER  = 1
Ship.static.STATE_ACTIVE = 2
Ship.static.STATE_DEAD   = 3

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

		if self.binding:isDown(self.shoot_action) and self.cooldown <= 0 and math.abs(self.direction - self.dead_zone) > SUPER_THRESHOLD then
			if math.abs(self.direction - self.super_zone) < SUPER_THRESHOLD then
				self.cooldown = SUPER_COOLDOWN
				self:getScene():add(Bullet(self.x, self.y-32, 1.5*math.pi, Bullet.static.TYPE_PLAYER_SUPER))
			else
				self.cooldown = BULLET_COOLDOWN
				self:getScene():add(Bullet(self.x, self.y-20, 1.5*math.pi, Bullet.static.TYPE_PLAYER_BULLET))
			end
		end
	end
end

function Ship:getGearSprite()
	return self.gear_sprite
end

function Ship:setDirection(direction)
	self.gear_sprite:setRotation(direction)
	self.direction = direction
end

function Ship:onCollide(o, dt, rt)
	if o:getName() == "gem" then
		self:getScene():find("controller"):addScore(o:getPoints())
		o:remove()
	end
end

function Ship:kill()
	self:getScene():add(Explosion(self.x, self.y, Explosion.static.SIZE_LARGE))
	self.state = Ship.static.STATE_DEAD
end

return Ship

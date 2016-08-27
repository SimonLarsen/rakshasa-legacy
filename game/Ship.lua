local Bullet = require("game.Bullet")

local Ship = class("game.Ship", prox.Entity)

Ship.static.SIDE_LEFT = 1
Ship.static.SIDE_RIGHT = 2

local FAST_SPEED = 250
local SLOW_SPEED = 150

local BULLET_COOLDOWN = 0.1

function Ship:enter(x, y, side)
	self.x, self.y = x, y
	self.side = side
	self.cooldown = 0

	self.joystick = prox.JoystickBinding(1, 0.1)

	self:setRenderer(prox.MultiRenderer())
	self.gear_sprite = prox.Sprite("data/images/ship_gear.png", 19, 19)

	if side == Ship.static.SIDE_LEFT then
		self.joystick:add("shoot", "leftshoulder")
		self.xaxis = "leftx"
		self.yaxis = "lefty"

		self.ship_sprite = prox.Sprite("data/images/ship_left.png", 28, 27)
		self:getRenderer():addRenderer(self.gear_sprite, 0, 1)
		self:getRenderer():addRenderer(self.ship_sprite)
	else
		self.joystick:add("shoot", "rightshoulder")
		self.xaxis = "rightx"
		self.yaxis = "righty"

		self.ship_sprite = prox.Sprite("data/images/ship_right.png", 11, 27)
		self:getRenderer():addRenderer(self.gear_sprite, 1, 1)
		self:getRenderer():addRenderer(self.ship_sprite)
	end
end

function Ship:update(dt, rt)
	-- Move ship
	local speed = self.joystick:isDown("shoot") and SLOW_SPEED or FAST_SPEED

	self.x = prox.math.cap(self.x + speed * dt * self.joystick:getAxis(self.xaxis), 10, prox.window.getWidth()-10)
	self.y = prox.math.cap(self.y + speed * dt * self.joystick:getAxis(self.yaxis), 10, prox.window.getHeight()-10)

	-- Shoot
	self.cooldown = self.cooldown - dt

	if self.joystick:isDown("shoot") and self.cooldown <= 0 then
		self.cooldown = BULLET_COOLDOWN
		self:getScene():add(Bullet(self.x, self.y, Bullet.static.OWNER_PLAYER))
	end
end

function Ship:getGearSprite()
	return self.gear_sprite
end

return Ship

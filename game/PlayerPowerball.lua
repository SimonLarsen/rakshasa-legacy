local Bullet = require("game.Bullet")

local PlayerPowerball = class("game.PlayerPowerball", Bullet)

local MAX_SPEED = 300
local ACCELERATION = 600
local DAMAGE = 55
local DELAY = 9*0.07

function PlayerPowerball:enter(x, y)
	self:setName("player_powerball")
	self.x = x
	self.y = y
	self.z = -1
	self.delay = DELAY
	self.speed = 0

	self:setRenderer(prox.Animation("data/animations/powerball.lua"))
	self:getRenderer():setVisible(false)
	self:setCollider(prox.BoxCollider(30, 30))
end

function PlayerPowerball:update(dt, rt)
	if self.delay > 0 then
		self.delay = self.delay - dt
		if self.delay <= 0 then
			self:getRenderer():setVisible(true)
		end
		return
	end

	self.speed = prox.math.movetowards(self.speed, MAX_SPEED, ACCELERATION*dt)
	self.y = self.y - self.speed * dt

	if self.x < -16 or self.x > settings.screen_width+16
	or self.y < -16 or self.y > settings.screen_height+16 then
		self:remove()
	end
end

function PlayerPowerball:getDamage()
	return DAMAGE
end

function PlayerPowerball:onCollide(o, dt, rt) end

return PlayerPowerball

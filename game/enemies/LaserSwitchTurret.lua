local Enemy = require("game.Enemy")
local Explosion = require("game.Explosion")
local Gem = require("game.Gem")

local LaserSwitchTurret = class("game.enemies.LaserSwitchTurret", Enemy)

local MAX_HEALTH = 4

function LaserSwitchTurret:enter(x, y, speed)
	Enemy.enter(self, MAX_HEALTH)
	self.x = x
	self.y = y
	self.speed = speed
	self.destroyed = false

	self:setRenderer(prox.Animator("data/animators/enemies/laser_switch_turret.lua"))
	self:setCollider(prox.BoxCollider(32, 32))
end

function LaserSwitchTurret:update(dt, rt)
	self.y = self.y + self.speed * dt

	if self.y > prox.window.getHeight() + 20 then
		self.destroyed = true
		self:remove()
	end
end

function LaserSwitchTurret:isDestroyed()
	return self.destroyed or not self:isAlive()
end

function LaserSwitchTurret:kill()
	self:getScene():add(Explosion(self.x, self.y, Explosion.static.SIZE_MEDIUM))
	self:getScene():find("screenshaker"):shake(0.3, 1, 60)
	self.sfx_explosion1:play()

	for i=1, self:getGems() do
		self:getScene():add(Gem(
			self.x + love.math.random(-8, 8),
			self.y + love.math.random(-8, 8)
		))
	end

	self:setCollider(nil)
	self:getRenderer():setProperty("state", false)
	self.destroyed = true
end

function LaserSwitchTurret:getGems()
	return 5
end

return LaserSwitchTurret

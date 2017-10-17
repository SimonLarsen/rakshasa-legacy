local Enemy = require("game.Enemy")
local Explosion = require("game.Explosion")
local Gem = require("game.Gem")

local LaserSwitchTurret = class("game.enemies.LaserSwitchTurret", Enemy)

function LaserSwitchTurret:enter(x, y, dir, speed)
	Enemy.enter(self)
	self.x = x
	self.y = y
	self.z = 2
	self.speed = speed
	self.destroyed = false

	self:setRenderer(prox.Animator("data/animators/enemies/laser_switch_turret.lua"))
	self:getRenderer():setScale(dir, 1)
	self:setCollider(prox.BoxCollider(28, 28))
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
	if self.large then
		self:getScene():add(Explosion(self.x, self.y, Explosion.static.SIZE_LARGE))
		self:getScene():find("screenshaker"):shake(0.5, 2, 60)
		local sfx = prox.resources.getSound("data/sounds/explosion3.wav")
		self.sfx_explosion3:play()
	else
		self:getScene():add(Explosion(self.x, self.y, Explosion.static.SIZE_MEDIUM))
		self:getScene():find("screenshaker"):shake(0.3, 1, 60)
		self.sfx_explosion1:play()
	end
	
	local num_gems = self:getGems()
	local spread = math.log(math.max(15, num_gems)) * 30
	for i=1, num_gems do
		self:getScene():add(Gem(self.x, self.y, spread))
	end

	self:setCollider(nil)
	self:getRenderer():setProperty("state", false)
	self.destroyed = true
end

return LaserSwitchTurret

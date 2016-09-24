local shaders = require("shaders")
local Explosion = require("game.Explosion")
local Gem = require("game.Gem")

local Enemy = class("game.Enemy", prox.Entity)

function Enemy:enter(health, large)
	self.max_health = health
	self.health = self.max_health
	self.hit = 0
	self.large = large or false

	self.white_shader = shaders.getShader("data/shaders/whiteout.lua")
end

function Enemy:onCollide(o, dt, rt)
	if o:getName() == "bullet" and o:isPlayerBullet() then
		self.health = self.health - o:getDamage()
		self.hit = 0.05
		if self.health <= 0 then
			self:kill()
		end
		o:kill()
	end
end

function Enemy:update(dt, rt)
	self.hit = self.hit - dt
	self:getRenderer():setShader(self.hit > 0 and self.white_shader or nil)
end

function Enemy:kill()
	if self.large then
		self:getScene():add(Explosion(self.x, self.y, Explosion.static.SIZE_LARGE))
		self:getScene():find("screenshaker"):shake(0.5, 2, 60)
	else
		self:getScene():add(Explosion(self.x, self.y, Explosion.static.SIZE_MEDIUM))
	end
	
	for i=1, self:getGems() do
		self:getScene():add(Gem(
			self.x + love.math.random(-8, 8),
			self.y + love.math.random(-8, 8)
		))
	end

	self:remove()
end

return Enemy

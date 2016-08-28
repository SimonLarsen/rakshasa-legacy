local Explosion = require("game.Explosion")
local Gem = require("game.Gem")

local Enemy = class("game.Enemy", prox.Entity)

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

function Enemy:kill()
	self:getScene():add(Explosion(self.x, self.y))

	for i=1, self:getGems() do
		self:getScene():add(Gem(
			self.x + love.math.random(-8, 8),
			self.y + love.math.random(-8, 8)
		))
	end

	self:remove()
end

return Enemy

local Explosion = require("game.Explosion")

local Enemy = class("game.Enemy", prox.Entity)

function Enemy:onCollide(o, dt, rt)
	if o:getName() == "bullet" and o:isPlayerBullet() then
		self.health = self.health - o:getDamage()
		if self.health <= 0 then
			self:kill()
		end
		o:kill()
	end
end

function Enemy:kill()
	self:getScene():add(Explosion(self.x, self.y))
	self:remove()
end

return Enemy

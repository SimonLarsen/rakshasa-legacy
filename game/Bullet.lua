local Explosion = require("game.Explosion")

local Bullet = class("game.Bullet", prox.Entity)

function Bullet:kill()
	self:getScene():add(Explosion(self.x, self.y, Explosion.static.SIZE_SMALL))
	self:remove()
end

function Bullet:onCollide(o, dt, rt)
	if o:isInstanceOf(Bullet) and o:getName() == "player_powerball" then
		self:kill()
	end
end

return Bullet

local Explosion = class("game.Explosion", prox.Entity)

function Explosion:enter(x, y)
	self.x = x
	self.y = y
	self.z = 3
	self:setRenderer(prox.Animation("data/animations/explosion.lua"))
end

function Explosion:update(dt, rt)
	if self:getRenderer():isFinished() then
		self:remove()
	end
end

return Explosion

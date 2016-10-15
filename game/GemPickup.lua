local GemPickup = class("game.GemPickup", prox.Entity)

function GemPickup:enter(x, y)
	self.x = x
	self.y = y
	self.z = -1

	self:setRenderer(prox.Animation("data/animations/gem_pickup.lua"))
end

function GemPickup:update(dt, rt)
	if self:getRenderer():isFinished() then
		self:remove()
	end
end

return GemPickup

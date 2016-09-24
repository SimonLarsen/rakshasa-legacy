local PickupBlink = class("game.PickupBlink", prox.Entity)

function PickupBlink:enter(x, y)
	self.x = x
	self.y = y
	self.z = -1
	self:setRenderer(prox.Animation("data/animations/pickup_blink.lua"))
end

function PickupBlink:update(dt, rt)
	if self:getRenderer():isFinished() then
		self:remove()
	end
end

return PickupBlink

local PurityDrone = class("game.PurityDrone", prox.Entity)

function PurityDrone:enter(x, y, time)
	self.x = x
	self.y = y
	self.time = time

	self.z = 1

	self:setRenderer(prox.Animation("data/animations/purity_drone.lua"))
end

function PurityDrone:update(dt, rt)
	self.time = self.time - dt
	if self.time <= 0 then
		self:remove()
	end
end

return PurityDrone

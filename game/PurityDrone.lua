local PurityDrone = class("game.PurityDrone", prox.Entity)

function PurityDrone:enter(x, y, time, out_time)
	self.x = x
	self.y = y

	self.z = 1

	self:setRenderer(prox.Animator("data/animators/purity_drone.lua"))

	self.timer1 = prox.timer.after(time-out_time, function()
		self:getRenderer():setProperty("disappear", true)
	end)

	self.timer2 = prox.timer.after(time, function()
		self:remove()
	end)
end

function PurityDrone:onRemove()
	prox.timer.cancel(self.timer1)
	prox.timer.cancel(self.timer2)
end

return PurityDrone

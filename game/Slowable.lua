local Slowable = class("game.Slowable", prox.Entity)

function Slowable:enter()
	self.time_speed = 1
end

function Slowable:update(dt, rt)
	dt = dt * self.time_speed
	return dt, rt
end

function Slowable:setTimeSpeed(speed)
	self.time_speed = speed
end

return Slowable

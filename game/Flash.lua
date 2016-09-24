local Flash = class("game.Flash", prox.Entity)

function Flash:enter(x, y, speed)
	self.x = x
	self.y = y
	self.z = -2

	self:setRenderer(prox.Animation("data/animations/flash.lua"))
	self:getRenderer():setSpeed(speed or 1)
end

function Flash:update(dt, rt)
	if self:getRenderer():isFinished() then
		self:remove()
	end
end

return Flash

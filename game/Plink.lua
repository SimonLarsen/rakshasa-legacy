local Plink = class("game.Plink", prox.Entity)

function Plink:enter(x, y, speed)
	self.x = x
	self.y = y
	self.z = -2

	self:setRenderer(prox.Animation("data/animations/plink.lua"))
	self:getRenderer():setSpeed(speed or 1)
end

function Plink:update(dt, rt)
	if self:getRenderer():isFinished() then
		self:remove()
	end
end

return Plink

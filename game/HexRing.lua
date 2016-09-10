local HexRing = class("game.HexRing", prox.Entity)

function HexRing:enter(x, y, radius, intensity, duration)
	self.hexgrid = self:getScene():find("hexgrid")
	self.cx, self.cy = self.hexgrid:positionToCell(x, y)

	self.radius = radius
	self.intensity = intensity
	self.duration = duration
	self.time = 0

end

function HexRing:update(dt, rt)
	self.time = self.time + dt

	if self.time >= self.duration then
		self:remove()
	end
end

return HexRing

local Explosion = class("game.Explosion", prox.Entity)

Explosion.static.SIZE_SMALL  = 1
Explosion.static.SIZE_MEDIUM = 2
Explosion.static.SIZE_LARGE  = 3

local HEX_STEP_DELAY = 0.05
function Explosion:enter(x, y, size)
	self.x = x
	self.y = y
	self.z = -1
	self.hex_r = size
	self.hex_step = 1
	self.hex_next_step = 0

	if size == Explosion.static.SIZE_SMALL then
		self.hex_r = 0
		self:setRenderer(prox.Animation("data/animations/explosion_small.lua"))
	elseif size == Explosion.static.SIZE_MEDIUM then
		self:setRenderer(prox.Animation("data/animations/explosion.lua"))
	elseif size == Explosion.static.SIZE_LARGE then
		self:setRenderer(prox.Animation("data/animations/explosion_big.lua"))
	else
		error("Unknown explosion size.")
	end
end

function Explosion:update(dt, rt)
	if self.hex_step <= self.hex_r then
		self.hex_next_step = self.hex_next_step - dt
		if self.hex_next_step <= 0 then
			local hex = self:getScene():find("hexgrid")
			local cx, cy = hex:positionToCell(self.x, self.y)
			for x, y in hex:getRingCorners(cx, cy, self.hex_step) do
				hex:setCell(x, y, 0.8)
			end

			self.hex_next_step = HEX_STEP_DELAY
			self.hex_step = self.hex_step + 1
		end
	end

	if self:getRenderer():isFinished() then
		self:remove()
	end
end

return Explosion

local Explosion = class("game.Explosion", prox.Entity)

Explosion.static.SIZE_SMALL  = 1
Explosion.static.SIZE_MEDIUM = 2
Explosion.static.SIZE_LARGE  = 3

local SPLATTER_COUNT = {
	[Explosion.static.SIZE_SMALL]  = 14,
	[Explosion.static.SIZE_MEDIUM] = 18,
	[Explosion.static.SIZE_LARGE]  = 30
}

local HEX_STEP_DELAY = 0.08
function Explosion:enter(x, y, size)
	self.x = x
	self.y = y
	self.z = -1

	if size == Explosion.static.SIZE_SMALL then
		self:setRenderer(prox.Animation("data/animations/explosion_small.lua"))
	elseif size == Explosion.static.SIZE_MEDIUM then
		self:setRenderer(prox.Animation("data/animations/explosion.lua"))
	elseif size == Explosion.static.SIZE_LARGE then
		self:setRenderer(prox.Animation("data/animations/explosion_big.lua"))
	else
		error("Unknown explosion size.")
	end

	if size ~= Explosion.static.SIZE_SMALL then
		self:getScene():find("painting"):addSplatter(self.x, self.y, 16)
	end
end

function Explosion:update(dt, rt)
	if self:getRenderer():isFinished() then
		self:remove()
	end
end

return Explosion

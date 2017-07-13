local BulletPattern = class("game.bullet.BulletPattern")

function BulletPattern:initialize(parent, ox, oy)
	assert(parent ~= nil, "BulletPattern needs parent Entity")
	self.parent = parent
	self.ox = ox or 0
	self.oy = oy or 0
end

function BulletPattern:update(dt) end
function BulletPattern:reset() end
function BulletPattern:shoot(x, y) end

function BulletPattern:getPosition()
	return self.parent.x+self.ox, self.parent.y+self.oy
end

return BulletPattern

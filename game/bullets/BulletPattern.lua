local BulletPattern = class("game.bullet.BulletPattern")

function BulletPattern:initialize(parent)
	assert(parent ~= nil, "BulletPattern needs parent Entity")
	self.parent = parent
end

function BulletPattern:update(dt) end
function BulletPattern:reset() end
function BulletPattern:shoot(x, y) end

return BulletPattern

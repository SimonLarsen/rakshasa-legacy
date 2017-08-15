local Slowable = require("game.Slowable")
local Explosion = require("game.Explosion")

local EnemyBullet = class("game.EnemyBullet", Slowable)

local MOVE_SPEED = 120

EnemyBullet.static.TYPE_LASER  = 1
EnemyBullet.static.TYPE_BALL   = 2
EnemyBullet.static.TYPE_CHARGE = 3
EnemyBullet.static.TYPE_RAIN   = 4

local animations = {
	[EnemyBullet.static.TYPE_LASER]  = "data/animations/bullets/enemy_ball.lua",
	[EnemyBullet.static.TYPE_BALL]   = "data/animations/bullets/enemy_ball.lua",
	[EnemyBullet.static.TYPE_CHARGE] = "data/animations/bullets/enemy_ball.lua",
	[EnemyBullet.static.TYPE_RAIN]   = "data/animations/bullets/enemy_ball.lua"
}

function EnemyBullet:enter(x, y, dir, type)
	Slowable.enter(self)
	self.x = x
	self.y = y
	self.z = -1
	self.type = type
	self.dir = dir

	self:setRenderer(prox.Animation(animations[self.type]))
	self:setCollider(prox.BoxCollider(8, 8))
	self.hc_rect = HC.rectangle(0, 0, 8, 8)
end

function EnemyBullet:update(dt, rt)
	dt, rt = Slowable.update(self, dt, rt)
	local rot = self:getRenderer():getRotation()

	self.x = self.x + math.cos(self.dir) * MOVE_SPEED * dt
	self.y = self.y + math.sin(self.dir) * MOVE_SPEED * dt

	if self.x < -16 or self.x > settings.screen_width+16
	or self.y < -16 or self.y > settings.screen_height+16 then
		self:remove()
	end

	self.hc_rect:moveTo(self.x, self.y)

	return dt, rt
end

function EnemyBullet:getHCShape()
	return self.hc_rect
end

function EnemyBullet:kill()
	self:getScene():add(Explosion(self.x, self.y, Explosion.static.SIZE_SMALL))
	self:remove()
end

return EnemyBullet

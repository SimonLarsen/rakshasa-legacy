local Slowable = require("game.Slowable")
local Explosion = require("game.Explosion")

local EnemyBullet = class("game.EnemyBullet", Slowable)

EnemyBullet.static.TYPE_LASER  = 1
EnemyBullet.static.TYPE_BALL   = 2
EnemyBullet.static.TYPE_SALVO  = 3
EnemyBullet.static.TYPE_CHARGE = 4

local animations = {
	[EnemyBullet.static.TYPE_LASER]  = "data/animations/bullets/enemy_laser.lua",
	[EnemyBullet.static.TYPE_BALL]   = "data/animations/bullets/enemy_ball.lua",
	[EnemyBullet.static.TYPE_SALVO]  = "data/animations/bullets/enemy_salvo.lua",
	[EnemyBullet.static.TYPE_CHARGE] = "data/animations/bullets/enemy_ball.lua"
}

local hitboxes = {
	[EnemyBullet.static.TYPE_LASER]  = {w = 6, h = 16},
	[EnemyBullet.static.TYPE_BALL]   = {w = 8, h = 8},
	[EnemyBullet.static.TYPE_SALVO]  = {w = 10, h = 10},
	[EnemyBullet.static.TYPE_CHARGE] = {w = 8, h = 8}
}

local randomize_start_rotation = {
	[EnemyBullet.static.TYPE_LASER]  = false,
	[EnemyBullet.static.TYPE_BALL]   = true,
	[EnemyBullet.static.TYPE_SALVO]  = false,
	[EnemyBullet.static.TYPE_CHARGE] = true
}

local speed = {
	[EnemyBullet.static.TYPE_LASER]  = 150,
	[EnemyBullet.static.TYPE_BALL]   = 120,
	[EnemyBullet.static.TYPE_SALVO]  = 130,
	[EnemyBullet.static.TYPE_CHARGE] = 120
}

local rotation_speed = {
	[EnemyBullet.static.TYPE_LASER]  = 0,
	[EnemyBullet.static.TYPE_BALL]   = 8,
	[EnemyBullet.static.TYPE_SALVO]  = 0,
	[EnemyBullet.static.TYPE_CHARGE] = 8
}

function EnemyBullet:enter(x, y, dir, type)
	Slowable.enter(self)
	self.x = x
	self.y = y
	self.z = -1
	self.type = type
	self.dir = dir

	self:setRenderer(prox.Animation(animations[self.type]))
	self:setCollider(prox.BoxCollider(hitboxes[self.type].w, hitboxes[self.type].h))
	self.hc_rect = HC.rectangle(0, 0, hitboxes[self.type].w, hitboxes[self.type].h)

	if randomize_start_rotation[self.type] then
		self:getRenderer():setRotation(love.math.random()*2*math.pi)
	else
		self:getRenderer():setRotation(self.dir - math.pi/2)
	end
end

function EnemyBullet:update(dt, rt)
	dt, rt = Slowable.update(self, dt, rt)
	local rot = self:getRenderer().r
	self:getRenderer().r = rot + rotation_speed[self.type] * dt

	self.x = self.x + math.cos(self.dir) * speed[self.type] * dt
	self.y = self.y + math.sin(self.dir) * speed[self.type] * dt

	if self.x < -16 or self.x > settings.screen_width+16
	or self.y < -16 or self.y > settings.screen_height+16 then
		self:remove()
	end
end

function EnemyBullet:getHCShape()
	self.hc_rect:moveTo(self.x, self.y)
	return self.hc_rect
end

function EnemyBullet:kill()
	self:getScene():add(Explosion(self.x, self.y, Explosion.static.SIZE_SMALL))
	self:remove()
end

return EnemyBullet

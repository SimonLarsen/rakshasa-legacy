local Bullet = require("game.Bullet")

local EnemyBullet = class("game.EnemyBullet", Bullet)

local SPEED = 200
local ROTATION_SPEED = 8

EnemyBullet.static.TYPE_LASER = 1
EnemyBullet.static.TYPE_BALL = 2

function EnemyBullet:enter(x, y, dir, type)
	self:setName("enemy_bullet")
	self.x = x
	self.y = y
	self.z = -1
	self.type = type
	self.dir = dir
	self.time_speed = 1

	self:setRenderer(prox.Sprite("data/images/bullet_enemy.png"))
	self:setCollider(prox.BoxCollider(4, 4))
	self.hc_rect = HC.rectangle(0, 0, 4, 4)
	self:getRenderer():setRotation(love.math.random()*2*math.pi)
end

function EnemyBullet:update(dt, rt)
	dt = dt * self.time_speed
	local rot = self:getRenderer().r
	self:getRenderer().r = rot + ROTATION_SPEED * dt

	self.x = self.x + math.cos(self.dir) * SPEED * dt
	self.y = self.y + math.sin(self.dir) * SPEED * dt

	if self.x < -16 or self.x > settings.screen_width+16
	or self.y < -16 or self.y > settings.screen_height+16 then
		self:remove()
	end
end

function Bullet:getHCShape()
	self.hc_rect:moveTo(self.x, self.y)
	return self.hc_rect
end

function Bullet:setTimeSpeed(speed)
	self.time_speed = speed
end

return EnemyBullet

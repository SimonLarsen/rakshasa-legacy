local Explosion = require("game.Explosion")

local Bullet = class("game.Bullet", prox.Entity)

Bullet.static.TYPE_PLAYER_BULLET = 1
Bullet.static.TYPE_PLAYER_SUPER  = 2
Bullet.static.TYPE_PLAYER_ULTRA  = 3
Bullet.static.TYPE_ENEMY_BULLET  = 4

local bullet_speed = {
	[Bullet.static.TYPE_PLAYER_BULLET] = 500,
	[Bullet.static.TYPE_PLAYER_SUPER]  = 750,
	[Bullet.static.TYPE_PLAYER_ULTRA]  = 1000,
	[Bullet.static.TYPE_ENEMY_BULLET]  = 200
}

local bullet_acceleration = {
	[Bullet.static.TYPE_PLAYER_BULLET] = 10000,
	[Bullet.static.TYPE_PLAYER_SUPER]  = 1500,
	[Bullet.static.TYPE_PLAYER_ULTRA]  = 5000,
	[Bullet.static.TYPE_ENEMY_BULLET]  = 10000
}

local bullet_damage = {
	[Bullet.static.TYPE_PLAYER_BULLET] = 1,
	[Bullet.static.TYPE_PLAYER_SUPER]  = 2,
	[Bullet.static.TYPE_PLAYER_ULTRA]  = 3,
	[Bullet.static.TYPE_ENEMY_BULLET] = 1
}

function Bullet:enter(x, y, dir, type)
	self:setName("bullet")
	self.x = x
	self.y = y
	self.z = -1
	self.dir = dir
	self.type = type
	self.speed = 0
	self.rotation_speed = 0

	if self.type == Bullet.static.TYPE_PLAYER_BULLET then
		self:setRenderer(prox.Sprite("data/images/bullet_player.png", 15, 3))
		self:setCollider(prox.BoxCollider(2, 2))
		self:getRenderer():setRotation(self.dir)
	elseif self.type == Bullet.static.TYPE_PLAYER_SUPER then
		self:setRenderer(prox.Sprite("data/images/bullet_super.png"))
		self:setCollider(prox.BoxCollider(4, 4))
		self:getRenderer():setRotation(self.dir)
	elseif self.type == Bullet.static.TYPE_PLAYER_ULTRA then
		self:setRenderer(prox.Sprite("data/images/bullet_super.png"))
		self:setCollider(prox.BoxCollider(4, 4))
		self:getRenderer():setRotation(self.dir)
	elseif self.type == Bullet.static.TYPE_ENEMY_BULLET then
		self:setRenderer(prox.Sprite("data/images/bullet_enemy.png"))
		self:setCollider(prox.BoxCollider(4, 4))
		self.hc_rect = HC.rectangle(0, 0, 4, 4)
		self.rotation_speed = 8
		self:getRenderer():setRotation(love.math.random()*2*math.pi)
	else
		error(string.format("Unknown enemy type \"%s\".", self.type))
	end
end

function Bullet:update(dt, rt)
	local rot = self:getRenderer().r
	self:getRenderer().r = rot + self.rotation_speed * dt

	self.speed = prox.math.movetowards(self.speed, bullet_speed[self.type], bullet_acceleration[self.type]*dt)

	self.x = self.x + math.cos(self.dir) * self.speed * dt
	self.y = self.y + math.sin(self.dir) * self.speed * dt

	if self.x < -16 or self.x > settings.screen_width+16
	or self.y < -16 or self.y > settings.screen_height+16 then
		self:remove()
	end
end

function Bullet:kill()
	self:getScene():add(Explosion(self.x, self.y, Explosion.static.SIZE_SMALL))
	self:remove()
end

function Bullet:getType()
	return self.type
end

function Bullet:getDamage()
	return bullet_damage[self.type]
end

function Bullet:isPlayerBullet()
	return self.type <= Bullet.static.TYPE_PLAYER_ULTRA
end

function Bullet:getHCShape()
	self.hc_rect:moveTo(self.x, self.y)
	return self.hc_rect
end

return Bullet

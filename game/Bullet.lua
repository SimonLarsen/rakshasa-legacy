local Explosion = require("game.Explosion")

local Bullet = class("game.Bullet", prox.Entity)

Bullet.static.TYPE_PLAYER_BULLET = 1
Bullet.static.TYPE_PLAYER_SUPER  = 2
Bullet.static.TYPE_PLAYER_ULTRA  = 3
Bullet.static.TYPE_PLAYER_BALL   = 4
Bullet.static.TYPE_ENEMY_BULLET  = 5

local bullet_speed = {
	[Bullet.static.TYPE_PLAYER_BULLET] = 500,
	[Bullet.static.TYPE_PLAYER_SUPER]  = 500,
	[Bullet.static.TYPE_PLAYER_ULTRA]  = 500,
	[Bullet.static.TYPE_PLAYER_BALL]   = 300,
	[Bullet.static.TYPE_ENEMY_BULLET]  = 200
}

local bullet_acceleration = {
	[Bullet.static.TYPE_PLAYER_BULLET] = 10000,
	[Bullet.static.TYPE_PLAYER_SUPER]  = 10000,
	[Bullet.static.TYPE_PLAYER_ULTRA]  = 10000,
	[Bullet.static.TYPE_PLAYER_BALL]   = 600,
	[Bullet.static.TYPE_ENEMY_BULLET]  = 10000
}

local bullet_damage = {
	[Bullet.static.TYPE_PLAYER_BULLET] = 1.0,
	[Bullet.static.TYPE_PLAYER_SUPER]  = 2.6,
	[Bullet.static.TYPE_PLAYER_ULTRA]  = 4.8,
	[Bullet.static.TYPE_PLAYER_BALL]   = 64.0,
	[Bullet.static.TYPE_ENEMY_BULLET]  = 1.0
}

local is_player_bullet = {
	[Bullet.static.TYPE_PLAYER_BULLET] = true,
	[Bullet.static.TYPE_PLAYER_SUPER]  = true,
	[Bullet.static.TYPE_PLAYER_ULTRA]  = true,
	[Bullet.static.TYPE_PLAYER_BALL]   = true,
	[Bullet.static.TYPE_ENEMY_BULLET]  = false
}

local is_super = {
	[Bullet.static.TYPE_PLAYER_BULLET] = false,
	[Bullet.static.TYPE_PLAYER_SUPER]  = false,
	[Bullet.static.TYPE_PLAYER_ULTRA]  = false,
	[Bullet.static.TYPE_PLAYER_BALL]   = true,
	[Bullet.static.TYPE_ENEMY_BULLET]  = false
}

local is_dps = {
	[Bullet.static.TYPE_PLAYER_BULLET] = false,
	[Bullet.static.TYPE_PLAYER_SUPER]  = false,
	[Bullet.static.TYPE_PLAYER_ULTRA]  = false,
	[Bullet.static.TYPE_PLAYER_BALL]   = true,
	[Bullet.static.TYPE_ENEMY_BULLET]  = false
}

local delay = {
	[Bullet.static.TYPE_PLAYER_BULLET] = 0,
	[Bullet.static.TYPE_PLAYER_SUPER]  = 0,
	[Bullet.static.TYPE_PLAYER_ULTRA]  = 0,
	[Bullet.static.TYPE_PLAYER_BALL]   = 9*0.07,
	[Bullet.static.TYPE_ENEMY_BULLET]  = 0
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
		self:setRenderer(prox.Sprite("data/images/bullet_player1.png", 12, 4))
		self:setCollider(prox.BoxCollider(2, 2))
		self:getRenderer():setRotation(self.dir)
	elseif self.type == Bullet.static.TYPE_PLAYER_SUPER then
		self:setRenderer(prox.Sprite("data/images/bullet_player2.png", 8, 7))
		self:setCollider(prox.BoxCollider(4, 4))
		self:getRenderer():setRotation(self.dir)
	elseif self.type == Bullet.static.TYPE_PLAYER_ULTRA then
		self:setRenderer(prox.Sprite("data/images/bullet_player3.png", 11, 11))
		self:setCollider(prox.BoxCollider(4, 4))
		self:getRenderer():setRotation(self.dir)
	elseif self.type == Bullet.static.TYPE_PLAYER_BALL then
		self:setRenderer(prox.Animation("data/animations/powerball.lua"))
		self:setCollider(prox.BoxCollider(30, 30))
	elseif self.type == Bullet.static.TYPE_ENEMY_BULLET then
		self:setRenderer(prox.Sprite("data/images/bullet_enemy.png"))
		self:setCollider(prox.BoxCollider(4, 4))
		self.hc_rect = HC.rectangle(0, 0, 4, 4)
		self.rotation_speed = 8
		self:getRenderer():setRotation(love.math.random()*2*math.pi)
	else
		error(string.format("Unknown bullet type \"%s\".", self.type))
	end

	self.delay = delay[self.type]
	if self.delay > 0 then
		self:getRenderer():setVisible(false)
	end
end

function Bullet:update(dt, rt)
	local rot = self:getRenderer().r
	self:getRenderer().r = rot + self.rotation_speed * dt

	if self.delay > 0 then
		self.delay = self.delay - dt
		if self.delay <= 0 then
			self:getRenderer():setVisible(true)
		end
		return
	end

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
	return is_player_bullet[self.type]
end

function Bullet:isDPS()
	return is_dps[self.type]
end

function Bullet:isSuper()
	return is_super[self.type]
end

function Bullet:getHCShape()
	self.hc_rect:moveTo(self.x, self.y)
	return self.hc_rect
end

function Bullet:onCollide(o, dt, rt)
	if self.type == Bullet.static.TYPE_PLAYER_BALL then
		if o:getName() == "bullet" and o:getType() ~= Bullet.static.TYPE_PLAYER_BALL then
			o:kill()
		end
	end
end

return Bullet

local Enemy = require("game.Enemy")
local Bullet = require("game.Bullet")

local EnemyTemple = class("game.EnemyTemple", Enemy)

local MAX_HEALTH = 40

local MOVE_SPEED = 20
local BULLET_COOLDOWN = 3

function EnemyTemple:enter(x)
	self.x = x
	self.y = -30
	self.cooldown = 4
	self.health = MAX_HEALTH

	self:setRenderer(prox.Sprite("data/images/enemy_temple.png", 45, 36))
	self:setCollider(prox.BoxCollider(80, 32))
end

function EnemyTemple:update(dt, rt)
	self.y = self.y + MOVE_SPEED * dt

	if self.y > prox.window.getHeight()+30 then
		self:remove()
	end

	self.cooldown = self.cooldown - dt
	if self.cooldown <= 0 then
		self.cooldown = BULLET_COOLDOWN
		self:shoot()
	end
end

function EnemyTemple:shoot()
	self:getScene():add(Bullet(self.x-38, self.y+18, math.pi/2, Bullet.static.TYPE_ENEMY_BULLET))
	self:getScene():add(Bullet(self.x+39, self.y+18, math.pi/2, Bullet.static.TYPE_ENEMY_BULLET))
end

return EnemyTemple

local Enemy = require("game.Enemy")
local EnemyBullet = require("game.EnemyBullet")
local Flash = require("game.Flash")

local Temple = class("game.Temple", Enemy)

local MAX_HEALTH = 50

local MOVE_SPEED = 20
local BULLET_COOLDOWN = 3

function Temple:enter(x)
	dt, rt = Enemy.enter(self, MAX_HEALTH, true)

	self.x = x
	self.y = -30
	self.cooldown = 4

	self:setRenderer(prox.Animation("data/animations/enemies/temple.lua"))
	self:setCollider(prox.BoxCollider(80, 32))
end

function Temple:update(dt, rt)
	dt, rt = Enemy.update(self, dt, rt)

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

function Temple:shoot()
	self:getScene():add(EnemyBullet(self.x-38, self.y+18, math.pi/2, EnemyBullet.static.TYPE_LASER))
	self:getScene():add(EnemyBullet(self.x+39, self.y+18, math.pi/2, EnemyBullet.static.TYPE_LASER))
	self:getScene():add(Flash(self.x-38, self.y+18))
	self:getScene():add(Flash(self.x+39, self.y+18))
end

function Temple:getGems()
	return 5
end

return Temple

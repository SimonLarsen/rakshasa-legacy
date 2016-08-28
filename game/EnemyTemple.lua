local shaders = require("shaders")
local Enemy = require("game.Enemy")
local Bullet = require("game.Bullet")

local EnemyTemple = class("game.EnemyTemple", Enemy)

local MAX_HEALTH = 50

local MOVE_SPEED = 20
local BULLET_COOLDOWN = 3

function EnemyTemple:enter(x)
	self.x = x
	self.y = -30
	self.cooldown = 4
	self.health = MAX_HEALTH
	self.hit = 0

	self:setRenderer(prox.Sprite("data/images/enemy_temple.png", 45, 36))
	self.white_shader = shaders.getShader("data/shaders/whiteout.lua")
	self:setCollider(prox.BoxCollider(80, 32))
end

function EnemyTemple:update(dt, rt)
	self.y = self.y + MOVE_SPEED * dt

	if self.y > prox.window.getHeight()+30 then
		self:remove()
	end

	self.hit = self.hit - dt
	self:getRenderer():setShader(self.hit > 0 and self.white_shader or nil)

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

function EnemyTemple:getGems()
	return 5
end

return EnemyTemple

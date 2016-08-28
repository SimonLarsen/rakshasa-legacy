local shaders = require("shaders")
local Enemy = require("game.Enemy")
local Bullet = require("game.Bullet")
local Explosion = require("game.Explosion")

local EnemyMine = class("game.EnemyMine", Enemy)

local MAX_HEALTH = 10
local MOVE_SPEED = 25

function EnemyMine:enter(x, ylimit)
	self.x = x
	self.y = -16
	self.ylimit = ylimit
	self.health = MAX_HEALTH
	self.hit = 0

	self:setRenderer(prox.Sprite("data/images/enemy_mine.png", 14, 13))
	self.white_shader = shaders.getShader("data/shaders/whiteout.lua")
	self:setCollider(prox.BoxCollider(28, 26))
end

function EnemyMine:update(dt, rt)
	self.y = self.y + MOVE_SPEED * dt

	if self.y > self.ylimit then
		self:getScene():add(Explosion(self.x, self.y))
		for i=0,3 do
			self:getScene():add(Bullet(self.x, self.y, i*math.pi/2, Bullet.static.TYPE_ENEMY_BULLET))
		end
		self:remove()
	end

	self.hit = self.hit - dt
	self:getRenderer():setShader(self.hit > 0 and self.white_shader or nil)

	if self.y > prox.window.getHeight() + 16 then
		self:remove()
	end
end

function EnemyMine:getGems()
	return 3
end

return EnemyMine

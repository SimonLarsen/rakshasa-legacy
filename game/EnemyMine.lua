local Enemy = require("game.Enemy")
local Bullet = require("game.Bullet")
local Explosion = require("game.Explosion")

local EnemyMine = class("game.EnemyMine", Enemy)

local MAX_HEALTH = 10
local MOVE_SPEED = 45

function EnemyMine:enter(x, ylimit)
	Enemy.enter(self, MAX_HEALTH)

	self.x = x
	self.y = -16
	self.ylimit = ylimit
	self.health = MAX_HEALTH

	self:setRenderer(prox.Sprite("data/images/enemy_mine.png", 14, 13))
	self:setCollider(prox.BoxCollider(28, 26))
end

function EnemyMine:update(dt, rt)
	Enemy.update(self, dt, rt)

	self.y = self.y + MOVE_SPEED * dt

	if self.y > self.ylimit then
		self:getScene():add(Explosion(self.x, self.y, Explosion.static.SIZE_MEDIUM))
		for i=0,3 do
			self:getScene():add(Bullet(self.x, self.y, i*math.pi/2, Bullet.static.TYPE_ENEMY_BULLET))
		end
		self:remove()
	end

	if self.y > prox.window.getHeight() + 16 then
		self:remove()
	end
end

function EnemyMine:getGems()
	return 3
end

return EnemyMine

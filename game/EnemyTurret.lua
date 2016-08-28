local Enemy = require("game.Enemy")
local Bullet = require("game.Bullet")

local EnemyTurret = class("game.EnemyTurret", Enemy)

local MAX_HEALTH = 15
local MOVE_SPEED = 15
local BULLET_COOLDOWN = 2.0

function EnemyTurret:enter(x)
	Enemy.enter(self, MAX_HEALTH)

	self.x = x
	self.y = -30
	self.cooldown = 2.5

	self.player_chain = self:getScene():find("chain")

	self:setRenderer(prox.Sprite("data/images/enemy_turret.png", 22, 15))
	self:setCollider(prox.BoxCollider(40, 26))
end

function EnemyTurret:update(dt, rt)
	Enemy.update(self, dt, rt)

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

function EnemyTurret:shoot()
	local xdist = self.player_chain.x - self.x
	local ydist = self.player_chain.y - self.y
	local dir = math.atan2(ydist, xdist)
	self:getScene():add(Bullet(self.x, self.y, dir, Bullet.static.TYPE_ENEMY_BULLET))
end

function EnemyTurret:getGems()
	return 2
end

return EnemyTurret

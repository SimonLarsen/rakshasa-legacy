local Enemy = require("game.Enemy")
local EnemyLaser = require("game.EnemyLaser")

local LaserTurret = class("game.LaserTurret", Enemy)

local MAX_HEALTH = 15
local MOVE_SPEED = 35
local COOLDOWN = 4.0

function LaserTurret:enter(properties)
	Enemy.enter(self, MAX_HEALTH)

	self.x = properties.x
	self.y = -30
	self.cooldown = 2.5
	
	self.player_chain = self:getScene():find("chain")

	self:setRenderer(prox.Sprite("data/images/enemies/laser_turret.png", 19, 19))
	self:setCollider(prox.BoxCollider(30, 30))
end

function LaserTurret:update(dt, rt)
	dt, rt = Enemy.update(self, dt, rt)

	self.y = self.y + MOVE_SPEED * dt
	if self.y > prox.window.getHeight()+30 then
		self:remove()
	end

	self.cooldown = self.cooldown - dt
	if self.cooldown <= 0 then
		self:shoot()
		self.cooldown = COOLDOWN
	end
end

function LaserTurret:shoot()
	local xdist = self.player_chain.x - self.x
	local ydist = self.player_chain.y - self.y
	local dir = math.atan2(ydist, xdist)
	self:getScene():add(EnemyLaser(self, 0, 0, dir, 1.0))
end

function LaserTurret:getGems()
	return 3
end

return LaserTurret

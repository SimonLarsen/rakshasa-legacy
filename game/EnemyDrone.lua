local Enemy = require("game.Enemy")
local EnemyBullet = require("game.EnemyBullet")
local Flash = require("game.Flash")

local EnemyDrone = class("game.EnemyDrone", Enemy)

local MAX_HEALTH = 1

local MOVE_SPEED = 90
local BULLET_COOLDOWN = 2.0

function EnemyDrone:enter(points)
	Enemy.enter(self, MAX_HEALTH)

	assert(#points >= 2, "EnemyDrone needs at least two points.")
	self.points = points
	self.x = self.points[1][1]
	self.y = self.points[1][2]
	self.target = 2

	self.cooldown = 2
	self.player_chain = self:getScene():find("chain")

	self:setRenderer(prox.Animation("data/animations/enemies/drone.lua"))
	self:setCollider(prox.BoxCollider(26, 26))
end

function EnemyDrone:update(dt, rt)
	dt, rt = Enemy.update(self, dt, rt)

	local xdist = self.points[self.target][1] - self.x
	local ydist = self.points[self.target][2] - self.y
	local dist = math.sqrt(xdist^2 + ydist^2)

	if dist < MOVE_SPEED*dt then
		self.x = self.points[self.target][1]
		self.y = self.points[self.target][2]

		if self.target == #self.points then
			self:remove()
		else
			self.target = self.target + 1
		end
	else
		self.x = prox.math.movetowards(self.x, self.points[self.target][1], MOVE_SPEED*dt)
		self.y = prox.math.movetowards(self.y, self.points[self.target][2], MOVE_SPEED*dt)
	end

	self.cooldown = self.cooldown - dt
	if self.cooldown <= 0 then
		self.cooldown = BULLET_COOLDOWN
		self:shoot()
	end

	local rot = self:getRenderer().r
	self:getRenderer().r = rot - 2*dt
end

function EnemyDrone:shoot()
	local xdist = self.player_chain.x - self.x
	local ydist = self.player_chain.y - self.y
	local dir = math.atan2(ydist, xdist)
	self:getScene():add(EnemyBullet(self.x, self.y, dir, EnemyBullet.static.TYPE_LASER))
	self:getScene():add(Flash(self.x, self.y))
end

function EnemyDrone:onRemove()
	if self.timer then
		prox.timer.cancel(self.timer)
	end
end

function EnemyDrone:getGems()
	return 1
end

return EnemyDrone

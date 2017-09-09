local Enemy = require("game.Enemy")
local EnemyBullet = require("game.EnemyBullet")
local Flash = require("game.Flash")

local Patrol = class("game.enemies.Patrol", Enemy)

local MAX_HEALTH = 4
local ENTER_COOLDOWN = 1.0
local COOLDOWN = 5.0
local ENTER_TIME = 1.5

Patrol.static.STATE_ENTER = 1
Patrol.static.STATE_IDLE  = 2

function Patrol:enter(properties)
	Enemy.enter(self, MAX_HEALTH)

	assert(#properties.points == 2, "Patrol needs exactly two points.")
	self.x = properties.points[1].x
	self.y = properties.points[1].y

	self.state = Patrol.static.STATE_ENTER
	self.speed = properties.speed or MOVE_SPEED
	self.cooldown = properties.cooldown or COOLDOWN
	self.next_shot = self.enter_cooldown or ENTER_COOLDOWN
	self.player_chain = self:getScene():find("chain")
	self.idle_time = 0

	self.destx = properties.points[2].x
	self.desty = properties.points[2].y

	self:setRenderer(prox.Animation("data/animations/enemies/fighter.lua"))
	self:setCollider(prox.BoxCollider(32, 24))

	self.enter_time = prox.timer.tween(
		properties.enter_time or ENTER_TIME,
		self, {x = self.destx, y = self.desty},
		"out-quad",
		function() self.state = Patrol.static.STATE_IDLE end
	)
end

function Patrol:update(dt, rt)
	if self.state == Patrol.static.STATE_IDLE then
		self.idle_time = self.idle_time + dt
		self.x = self.destx + math.sin(self.idle_time)*3
		self.y = self.desty + math.sin(self.idle_time*1.1)*3

		self.next_shot = self.next_shot - dt
		if self.next_shot <= 0 then
			self.next_shot = self.cooldown
			self:shoot()
		end
	end
end

function Patrol:shoot()
	local xdist = self.player_chain.x - self.x
	local ydist = self.player_chain.y - self.y
	local dir = math.atan2(ydist, xdist)
	self:getScene():add(EnemyBullet(self.x, self.y, dir, EnemyBullet.static.TYPE_BALL))
	self:getScene():add(Flash(self.x, self.y))
end

function Patrol:onRemove()
	prox.timer.cancel(self.enter_time)
end

function Patrol:getGems()
	return 3
end

return Patrol

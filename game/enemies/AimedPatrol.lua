local Enemy = require("game.Enemy")
local EnemyBullet = require("game.EnemyBullet")
local Flash = require("game.Flash")

local AimedPatrol = class("game.enemies.AimedPatrol", Enemy)

local MAX_HEALTH = 5
local ENTER_COOLDOWN = 1.0
local COOLDOWN = 5.0
local ENTER_TIME = 1.5

AimedPatrol.static.STATE_ENTER = 1
AimedPatrol.static.STATE_IDLE  = 2

function AimedPatrol:enter(properties)
	Enemy.enter(self, MAX_HEALTH)

	assert(#properties.points == 3, "AimedPatrol needs exactly three points.")
	self.x = properties.points[1].x
	self.y = properties.points[1].y

	self.state = AimedPatrol.static.STATE_ENTER
	self.speed = properties.speed or MOVE_SPEED
	self.cooldown = properties.cooldown or COOLDOWN
	self.next_shot = self.enter_cooldown or ENTER_COOLDOWN
	self.idle_time = 0

	self.destx = properties.points[2].x
	self.desty = properties.points[2].y
	self.shoot_dir = math.atan2(properties.points[3].y - properties.points[2].y, properties.points[3].x - properties.points[2].x)

	self:setRenderer(prox.Animation("data/animations/enemies/fighter.lua"))
	self:setCollider(prox.BoxCollider(32, 24))

	self.enter_time = prox.timer.tween(
		properties.enter_time or ENTER_TIME,
		self, {x = self.destx, y = self.desty},
		"out-quad",
		function() self.state = AimedPatrol.static.STATE_IDLE end
	)
end

function AimedPatrol:update(dt, rt)
	if self.state == AimedPatrol.static.STATE_IDLE then
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

function AimedPatrol:shoot()
	self:getScene():add(EnemyBullet(self.x, self.y, self.shoot_dir, EnemyBullet.static.TYPE_BALL))
	self:getScene():add(Flash(self.x, self.y))
end

function AimedPatrol:onRemove()
	prox.timer.cancel(self.enter_time)
end

function AimedPatrol:getGems()
	return 3
end

return AimedPatrol

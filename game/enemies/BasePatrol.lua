local Enemy = require("game.Enemy")

local BasePatrol = class("game.enemies.BasePatrol", Enemy)

local ENTER_COOLDOWN = 0.6
local COOLDOWN = 3.0
local ENTER_TIME = 1.4

BasePatrol.static.STATE_ENTER = 1
BasePatrol.static.STATE_IDLE  = 2

function BasePatrol:enter(properties, max_health)
	Enemy.enter(self, max_health, true)

	assert(#properties.points >= 2 and #properties.points <= 3, "BasePatrol needs either two or three points.")
	self.x = properties.points[1].x
	self.y = properties.points[1].y

	self.state = BasePatrol.static.STATE_ENTER
	self.cooldown = properties.cooldown or COOLDOWN
	self.next_shot = self.enter_cooldown or ENTER_COOLDOWN
	self.player_chain = self:getScene():find("chain")
	self.idle_time = 0

	self.destx = properties.points[2].x
	self.desty = properties.points[2].y

	self:setRenderer(prox.Animator("data/animators/enemies/patrol.lua"))
	self:setCollider(prox.BoxCollider(32, 32))
	if #properties.points == 3 then
		self.shoot_dir = math.atan2(properties.points[3].y - properties.points[2].y, properties.points[3].x - properties.points[2].x)
	end

	self.enter_time = prox.timer.tween(
		properties.enter_time or ENTER_TIME,
		self, {x = self.destx, y = self.desty},
		"out-quad",
		function()
			self.state = BasePatrol.static.STATE_IDLE
			self:getRenderer():setProperty("transform", true)
		end
	)
end

function BasePatrol:update(dt, rt)
	dt, rt = Enemy.update(self, dt, rt)

	if self.state == BasePatrol.static.STATE_IDLE then
		self.idle_time = self.idle_time + dt
		self.x = self.destx + math.sin(self.idle_time)*3
		self.y = self.desty + math.sin(self.idle_time*1.1)*3

		self.next_shot = self.next_shot - dt
		if self.next_shot <= 0 then
			self.next_shot = self.cooldown
			self:baseShoot()
		end
	end
end

function BasePatrol:baseShoot()
	local dir
	if self.shoot_dir then
		dir = self.shoot_dir
	else
		local xdist = self.player_chain.x - self.x
		local ydist = self.player_chain.y - self.y
		dir = math.atan2(ydist, xdist)
	end
	self:shoot(dir)
end

function BasePatrol:onRemove()
	prox.timer.cancel(self.enter_time)
end

return BasePatrol

local Enemy = require("game.Enemy")
local EnemyBullet = require("game.EnemyBullet")
local PatternManager = require("game.bullets.PatternManager")
local BasePattern = require("game.bullets.BasePattern")

local Falcon = class("game.enemies.Falcon", Enemy)

local MAX_HEALTH = 50
local IDLE_TIME = 1.0
local MOVE_TIME = 1.5

local POSITIONS = {
	80, 160, 240, 160
}

local ENTER_TIME = 1.5

Falcon.static.STATE_ENTER  = 1
Falcon.static.STATE_IDLE   = 2
Falcon.static.STATE_MOVING = 3

function Falcon:enter(properties)
	Enemy.enter(self, MAX_HEALTH, true)

	self.destx = properties.x
	self.desty = properties.y
	self.x = self.destx
	self.y = -44
	self.entered = false
	self.time = 0
	self.entered_time = 0
	self.state = Falcon.static.STATE_ENTER

	self.timer = prox.timer.tween(ENTER_TIME, self, {y=self.desty}, "out-quad",
		function()
			self.state = Falcon.static.STATE_IDLE
		end
	)

	self:setRenderer(prox.Animation("data/animations/enemies/falcon.lua"))
	self:setCollider(prox.BoxCollider(80, 32))

	self.pattern = PatternManager()

	self.pattern:add(BasePattern(self, {
		salvo_delay = 999,
		salvo_size = 4,
		shot_delay = 0.13,
		bullet_type = EnemyBullet.static.TYPE_LASER,
		target_player = true
	}), 2.5)

	self.pattern:add(BasePattern(self, {
		salvo_delay = 999,
		salvo_size = 8,
		shot_delay = 0.13,
		shot_count = 4,
		start_rotation = math.pi/2-0.9,
		shot_rotation_offset = 0.6,
		bullet_type = EnemyBullet.static.TYPE_BALL
	}), 2.5)

	self.position = 1
	local min_dist = 100000
	for i=1,#POSITIONS do
		local dist = math.abs(self.x - POSITIONS[i])
		if dist < min_dist then
			self.position = i
			min_dist = dist
		end
	end
end

function Falcon:update(dt, rt)
	dt, rt = Enemy.update(self, dt, rt)

	if self.state == Falcon.static.STATE_ENTER then return end

	self.entered_time = self.entered_time + dt

	self.y = self.desty + math.sin(self.entered_time*1.5)*8

	self.pattern:update(dt, rt)

	if self.state == Falcon.static.STATE_IDLE then
		self.time = self.time + dt
		if self.time >= IDLE_TIME then
			self.position = self.position % #POSITIONS + 1
			self.state = Falcon.static.STATE_MOVING
			prox.timer.tween(MOVE_TIME, self, {x = POSITIONS[self.position]}, "in-out-quad",
				function()
					self.state = Falcon.static.STATE_IDLE
					self.time = 0
				end
			)
		end
	end
end

function Falcon:onRemove()
	Enemy.onRemove(self)
	if self.timer then
		prox.timer.cancel(self.timer)
	end
end

function Falcon:getGems()
	return 12
end

return Falcon

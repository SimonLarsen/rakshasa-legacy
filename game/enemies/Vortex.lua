local Enemy = require("game.Enemy")
local EnemyBullet = require("game.EnemyBullet")
local BasePattern = require("game.bullets.BasePattern")
local MultiPattern = require("game.bullets.MultiPattern")
local PatternManager = require("game.bullets.PatternManager")

local Vortex = class("game.enemies.Vortex", Enemy)

local ENTER_TIME = 2.5

local PHASE2_HEALTH = 30

function Vortex:enter(properties)
	Enemy.enter(self, true)

	self.destx = properties.x
	self.desty = properties.y
	self.x = self.destx
	self.y = -44
	self.entered = false
	self.entered_time = 0
	self.phase = 1

	self:setRenderer(prox.Animation("data/animations/enemies/vortex.lua"))
	self:setCollider(prox.BoxCollider(78, 78))

	self.timer = prox.timer.tween(ENTER_TIME, self, {y=self.desty}, "out-quad", function() self.entered = true end)

	self.patterns = {}
	
	self.patterns[1] = BasePattern(self, {
		salvo_delay = 0.15,
		salvo_size = 1,
		shot_count = 2,
		shot_rotation_offset = math.pi,
		salvo_rotation_offset = 0.16
	})

	self.patterns[2] = PatternManager()

	self.patterns[2]:add(BasePattern(self, {
		salvo_delay = 999,
		shot_delay = 0.2,
		salvo_size = 8,
		target_player = true
	}), 2.0)

	self.patterns[2]:add(MultiPattern({
		BasePattern(self, {
			salvo_delay = 999,
			shot_delay = 0.13,
			salvo_size = 8,
			start_rotation = math.pi/2+0.05,
			rotation_speed = 0.7
		}),
		BasePattern(self, {
			salvo_delay = 999,
			shot_delay = 0.13,
			salvo_size = 8,
			start_rotation = math.pi/2-0.05,
			rotation_speed = -0.7
		})
	}), 1.5)

	self.patterns[2]:add(MultiPattern({
		BasePattern(self, {
			salvo_delay = 999,
			shot_delay = 0.13,
			salvo_size = 8,
			start_rotation = 0,
			rotation_speed = 0.7
		}),
		BasePattern(self, {
			salvo_delay = 999,
			shot_delay = 0.13,
			salvo_size = 8,
			start_rotation = math.pi,
			rotation_speed = -0.7
		})
	}), 2.0)
end

function Vortex:update(dt, rt)
	dt, rt = Enemy.update(self, dt, rt)

	if self.phase == 1 and self.health <= PHASE2_HEALTH then
		self.phase = self.phase + 1
	end

	if not self.entered then return end
	self.entered_time = self.entered_time + dt
	self.x = self.destx + math.sin(self.entered_time*0.4)*8
	self.y = self.desty + math.sin(self.entered_time*1.1)*8
	self.patterns[self.phase]:update(dt)
end

function Vortex:onRemove()
	Enemy.onRemove(self)
	prox.timer.cancel(self.timer)
end

return Vortex

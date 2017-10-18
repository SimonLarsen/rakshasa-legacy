local Enemy = require("game.Enemy")
local EnemyBullet = require("game.EnemyBullet")
local MultiPattern = require("game.bullets.MultiPattern")
local PatternManager = require("game.bullets.PatternManager")
local BasePattern = require("game.bullets.BasePattern")
local NonePattern = require("game.bullets.NonePattern")

local Vortex = class("game.enemies.Vortex", Enemy)

local ENTER_TIME = 2.5

local PHASE2_HEALTH = 40

function Vortex:enter(properties)
	Enemy.enter(self, true)

	self.destx = properties.x
	self.desty = properties.y
	self.x = self.destx
	self.y = -44
	self.entered = false
	self.entered_time = 0
	self.phase = 1
	self.invulnerable = 2.5

	self:setRenderer(prox.Animation("data/animations/enemies/vortex.lua"))
	self:setCollider(prox.BoxCollider(78, 78))

	self.timer = prox.timer.tween(ENTER_TIME, self, {y=self.desty}, "out-quad", function() self.entered = true end)

	self.patterns = {}
	
	self.patterns[1] = PatternManager()

	self.patterns[1]:add(BasePattern(self, 0, 0, {
		salvo_delay = 0.10,
		salvo_size = 1,
		shot_count = 2,
		start_rotation = 0,
		shot_rotation_offset = math.pi,
		salvo_rotation_offset = 0.16
	}), 1.1)

	self.patterns[1]:add(NonePattern(), 0.5)

	self.patterns[1]:add(BasePattern(self, 0, 0, {
		salvo_delay = 0.10,
		salvo_size = 1,
		shot_count = 2,
		start_rotation = 0,
		shot_rotation_offset = math.pi,
		salvo_rotation_offset = -0.16
	}), 1.1)

	self.patterns[1]:add(NonePattern(), 0.5)

	self.patterns[2] = PatternManager()

	for i=1,4 do
		self.patterns[2]:add(BasePattern(self, 0, 0, {
			salvo_delay = 999,
			shot_delay = 0.1,
			salvo_size = 8,
			target_player = true
		}), 0.31)

		self.patterns[2]:add(NonePattern(), 0.8)
	end

	self.patterns[2]:add(MultiPattern({
		BasePattern(self, 0, 0, {
			salvo_delay = 999,
			shot_delay = 0.13,
			salvo_size = 8,
			start_rotation = 0,
			rotation_speed = 0.7
		}),
		BasePattern(self, 0, 0, {
			salvo_delay = 999,
			shot_delay = 0.13,
			salvo_size = 8,
			start_rotation = math.pi,
			rotation_speed = -0.7
		})
	}), 2.0)

	self.patterns[2]:add(MultiPattern({
		BasePattern(self, 0, 0, {
			salvo_delay = 999,
			shot_delay = 0.13,
			salvo_size = 8,
			start_rotation = math.pi/2+0.25,
			rotation_speed = 0.7
		}),
		BasePattern(self, 0, 0, {
			salvo_delay = 999,
			shot_delay = 0.13,
			salvo_size = 8,
			start_rotation = math.pi/2-0.25,
			rotation_speed = -0.7
		})
	}), 1.5)
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

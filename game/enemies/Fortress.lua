local Enemy = require("game.Enemy")
local EnemyBullet = require("game.EnemyBullet")
local BasePattern = require("game.bullets.BasePattern")
local PatternManager = require("game.bullets.PatternManager")

local Fortress = class("game.enemies.Fortress", Enemy)

local MAX_HEALTH = 40
local ENTER_TIME = 2.5
local COOLDOWN = 2.5

function Fortress:enter(properties)
	Enemy.enter(self, MAX_HEALTH, true)

	self.destx = properties.x
	self.desty = properties.y
	self.x = self.destx
	self.y = -44
	self.entered = false
	self.entered_time = 0

	self.pattern = PatternManager()

	self.pattern:add(BasePattern(self, {
		salvo_delay = 100,
		salvo_size = 10,
		shot_delay = 0.1,
		shot_count = 4,
		shot_rotation_offset = math.pi / 2,
		rotation_speed = 1.5,
		bullet_type = EnemyBullet.static.TYPE_BALL,
		reset_rotation = true
	}), 2.5)

	self.pattern:add(BasePattern(self, {
		salvo_delay = 1,
		salvo_size = 5,
		shot_delay = 0.15,
		shot_count = 4,
		shot_rotation_offset = math.pi / 2,
		salvo_rotation_offset = math.pi / 4,
		bullet_type = EnemyBullet.static.TYPE_LASER
	}), 1.99)

	self.cooldown = 0
	self.shoot_dir = 0

	self:setRenderer(prox.Sprite("data/images/enemies/fortress.png"))
	self:setCollider(prox.BoxCollider(58, 58))

	self.enter_timer = prox.timer.tween(ENTER_TIME, self, {y=self.desty}, "out-quad", function() self.entered = true end)
end

function Fortress:update(dt, rt)
	dt, rt = Enemy.update(self, dt, rt)

	if not self.entered then return end
	self.entered_time = self.entered_time + dt

	self.x = self.destx + math.sin(self.entered_time*0.4)*50
	self.y = self.desty + math.sin(self.entered_time*1.1)*4
	self.pattern:update(dt)
end

function Fortress:onRemove()
	Enemy.onRemove(self)
	prox.timer.cancel(self.enter_timer)
end

function Fortress:getGems()
	return 15
end

return Fortress

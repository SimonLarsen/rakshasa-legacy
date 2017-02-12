local Enemy = require("game.Enemy")
local EnemyBullet = require("game.EnemyBullet")
local BasePattern = require("game.bullets.BasePattern")

local Vortex = class("game.enemies.Vortex", Enemy)

local MAX_HEALTH = 25
local ENTER_TIME = 2.5

function Vortex:enter(properties)
	Enemy.enter(self, MAX_HEALTH, true)

	self.destx = properties.x
	self.desty = properties.y
	self.x = self.destx
	self.y = -44
	self.entered = false
	self.entered_time = 0

	self:setRenderer(prox.Sprite("data/images/enemies/fortress.png"))
	self:setCollider(prox.BoxCollider(58, 58))

	self.timer = prox.timer.tween(ENTER_TIME, self, {y=self.desty}, "out-quad", function() self.entered = true end)

	self.pattern = BasePattern(self, {
		salvo_delay = 0.15,
		salvo_size = 1,
		shot_count = 2,
		shot_rotation_offset = math.pi,
		salvo_rotation_offset = 0.15,
		bullet_type = EnemyBullet.static.TYPE_LASER
	})
end

function Vortex:update(dt, rt)
	dt, rt = Enemy.update(self, dt, rt)

	if not self.entered then return end
	self.entered_time = self.entered_time + dt
	self.x = self.destx + math.sin(self.entered_time*0.4)*8
	self.y = self.desty + math.sin(self.entered_time*1.1)*8
	self.pattern:update(dt)
end

function Vortex:onRemove()
	Enemy.onRemove(self)
	prox.timer.cancel(self.timer)
end

function Vortex:getGems()
	return 20
end

return Vortex

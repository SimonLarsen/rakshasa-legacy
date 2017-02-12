local Slowable = require("game.Slowable")
local Explosion = require("game.Explosion")
local BasePattern = require("game.bullets.BasePattern")

local EnemyBulletBomb = class("game.EnemyBulletBomb", prox.Entity)

function EnemyBulletBomb:enter(x, y, destx, desty, enter_time, detonation_time, pattern)
	Slowable.enter(self)
	self.x = x
	self.y = y
	self.time = detonation_time
	self.pattern = BasePattern(self, pattern)

	self:setRenderer(prox.Animation("data/animations/bullets/bomb.lua"))
	self:getRenderer():setSpeed(4)

	self.timer = prox.timer.tween(enter_time, self, {x = destx, y = desty}, "out-cubic")
end

function EnemyBulletBomb:update(dt, rt)
	dt, rt = Slowable.update(self, dt, rt)

	self.time = self.time - dt

	if self.time < 1 then
		self:getRenderer():setSpeed(8)
	end

	if self.time <= 0 then
		self.pattern:shoot(self.x, self.y)
		self:getScene():add(Explosion(self.x, self.y, Explosion.static.SIZE_MEDIUM))
		self:remove()
	end
end

function EnemyBulletBomb:onRemove()
	prox.timer.cancel(self.timer)
end

return EnemyBulletBomb

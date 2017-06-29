local EnemyBullet = require("game.EnemyBullet")
local Slowable = require("game.Slowable")

local EnemyChargeBullet = class("game.EnemyChargeBullet", EnemyBullet)

function EnemyChargeBullet:enter(x, y, chargex, chargey, dir, charge_time)
	EnemyBullet.enter(self, x, y, dir, EnemyBullet.TYPE_CHARGE)
	self.charging = true

	self.timer = prox.timer.tween(charge_time, self, {x = chargex, y=chargey}, "out-back", function() self.charging = false end)
end

function EnemyChargeBullet:update(dt, rt)
	dt, rt = Slowable.update(self, dt, rt)

	if self.charging then
		self.hc_rect:moveTo(self.x, self.y)
	else
		EnemyBullet.update(self, dt, rt)
	end
end

function EnemyChargeBullet:onRemove()
	EnemyBullet.onRemove(self)

	if self.timer then
		prox.timer.cancel(self.timer)
	end
end

return EnemyChargeBullet

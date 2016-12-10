local EnemyBullet = require("game.EnemyBullet")

local EnemyChargeBullet = class("game.EnemyChargeBullet", EnemyBullet)

function EnemyChargeBullet:enter(x, y, chargex, chargey, dir, charge_time)
	EnemyBullet.enter(self, x, y, dir, EnemyBullet.TYPE_CHARGE)
	self.charging = true

	self.timer = prox.timer.tween(charge_time, self, {x = chargex, y=chargey}, "out-back", function() self.charging = false end)
end

function EnemyChargeBullet:update(dt, rt)
	if not self.charging then
		EnemyBullet.update(self, dt, rt)
	end
end

function EnemyChargeBullet:onRemove()
	if self.timer then
		prox.timer.cancel(self.timer)
	end
end

return EnemyChargeBullet

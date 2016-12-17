local EnemyBullet = require("game.EnemyBullet")
local Slowable = require("game.Slowable")

local EnemyRainBullet = class("game.EnemyRainBullet", EnemyBullet)

local GRAVITY = 200
local MAX_SPEED = 200

function EnemyRainBullet:enter(x, y, xspeed, yspeed)
	EnemyBullet.enter(self, x, y, 0, EnemyBullet.TYPE_RAIN)

	self.xspeed = xspeed
	self.yspeed = yspeed
end

function EnemyRainBullet:update(dt, rt)
	dt, rt = Slowable.update(self, dt, rt)

	self.yspeed = self.yspeed + GRAVITY*dt

	local speed = math.sqrt(self.xspeed^2 + self.yspeed^2)
	if speed > MAX_SPEED then
		self.xspeed = self.xspeed / speed * MAX_SPEED
		self.yspeed = self.yspeed / speed * MAX_SPEED
	end

	self.x = self.x + self.xspeed * dt
	self.y = self.y + self.yspeed * dt

	if self.y > settings.screen_height+20 then
		self:remove()
	end
end

return EnemyRainBullet

local EnemyBullet = require("game.EnemyBullet")
local EnemyBulletEgg = class("game.EnemyBulletEgg", EnemyBullet)
local BasePattern = require("game.bullets.BasePattern")

local MOVE_SPEED = 50
local ENTER_TIME = 1.4

function EnemyBulletEgg:enter(x, y, pattern)
	self.x = x
	self.y = y
	self.pattern = BasePattern(self, 0, 0, pattern)
	self.time = 0

	self:setRenderer(prox.Animator("data/animators/bullets/egg.lua"))
end

function EnemyBulletEgg:update(dt, rt)
	self.time = self.time + dt

	if self.time < ENTER_TIME then return end

	self.y = self.y + MOVE_SPEED * dt

	self.pattern:update(dt)

	if self.y > settings.screen_height + 16 then
		self:remove()
	end
end

return EnemyBulletEgg

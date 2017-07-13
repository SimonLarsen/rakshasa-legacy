local BulletPattern = require("game.bullets.BulletPattern")

local LambdaPattern = class("game.bullets.LambdaPattern", BulletPattern)

function LambdaPattern:initialize(parent, ox, oy, fun, params)
	BulletPattern.initialize(self, parent, ox, oy)

	self.fun = fun
	self.delay = params.delay or 0.1
	self.warmup = params.warmup or 0

	self:reset()
end

function LambdaPattern:reset()
	self.next_trigger = self.warmup
end

function LambdaPattern:update(dt)
	self.next_trigger = self.next_trigger - dt

	if self.next_trigger <= 0 then
		self.next_trigger = self.delay

		self.fun(self)
	end
end

return LambdaPattern

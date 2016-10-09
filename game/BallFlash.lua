local BallFlash = class("game.BallFlash", prox.Entity)

function BallFlash:enter(x, y, speed)
	self.x = x
	self.y = y
	self.z = -1

	self:setRenderer(prox.Animation("data/animations/ball_flash.lua"))
	self:getRenderer():setSpeed(speed or 1)
end

function BallFlash:update(dt, rt)
	if self:getRenderer():isFinished() then
		self:remove()
	end
end

return BallFlash

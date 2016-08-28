local ScreenShaker = class("game.ScreenShaker", prox.Entity)

function ScreenShaker:enter()
	self:setName("screenshaker")
	self.time = 0
	self.next_shake = 0

	self.strength = 0
	self.speed = 60
end

function ScreenShaker:update(dt, rt)
	local cx, cy = prox.window.getWidth()/2, prox.window.getHeight()/2

	if self.time > 0 then
		self.time = self.time - dt
		self.next_shake = self.next_shake - dt
		if self.next_shake <= 0 then
			cx = cx + (2 * love.math.random() - 1) * self.strength
			cy = cy + (2 * love.math.random() - 1) * self.strength
			self:getScene():getCamera():setPosition(cx, cy)
			self.next_shake = 1 / self.speed
		end
	else
		self:getScene():getCamera():setPosition(cx, cy)
	end
end

function ScreenShaker:shake(time, strength, speed)
	assert(self.speed > 0, "Screen shake speed must be greater than 0.")
	self.time = time
	self.strength = strength
	self.speed = speed
end

return ScreenShaker

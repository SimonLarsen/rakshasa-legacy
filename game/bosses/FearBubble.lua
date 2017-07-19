local FearBubble = class("game.bosses.FearBubble", prox.Entity)

FearBubble.static.STATE_ENTER = 1
FearBubble.static.STATE_MOVE = 2
FearBubble.static.STATE_BURST = 3

local SPAWN_TIME = 14*0.08
local BURST_TIME = 9*0.08
local BURST_DELAY = 5*0.08

function FearBubble:enter(x, y, destx, desty, spawn_time, f)
	self.x = x
	self.y = y
	self.z = -1
	self.destx = destx
	self.desty = desty
	self.move_time = spawn_time - SPAWN_TIME

	self.f = f
	self.time = 0
	self.state = FearBubble.static.STATE_ENTER

	self:setRenderer(prox.Animator("data/animators/egg.lua"))
end

function FearBubble:update(dt, rt)
	self.time = self.time + dt

	if self.state == FearBubble.static.STATE_ENTER then
		if self.time >= SPAWN_TIME then
			self.state = FearBubble.static.STATE_MOVE
			self.timer = prox.timer.tween(self.move_time, self, {x = self.destx, y=self.desty}, "in-out-quad", function()
				self.state = FearBubble.static.STATE_BURST
				self:getRenderer():setProperty("pop", true)
				self.time = 0
				prox.timer.after(BURST_DELAY, function() self.f() end)
			end)
		end
	elseif self.state == FearBubble.static.STATE_BURST then
		if self.time >= BURST_TIME then
			self:remove()
		end
	end
end

function FearBubble:onRemove()
	if self.timer then
		prox.timer.cancel(self.timer)
	end
end

return FearBubble

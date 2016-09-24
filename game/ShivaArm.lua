local Bullet = require("game.Bullet")
local Flash = require("game.Flash")

local ShivaArm = class("game.ShivaArm", prox.Entity)

local ENTER_TIME = 3

ShivaArm.static.SIDE_LEFT  = 1
ShivaArm.static.SIDE_RIGHT = 2

local patterns = {
	[1] = {
		{0.0, "shoot"},
		{0.2, "shoot"},
		{0.4, "shoot"},
		{0.6, "shoot"},
		{3.0, "wait"}
	}
}

local positions = {
	180, 310, 450, 310
}

function ShivaArm:enter(side)
	self.side = side

	self.y = -80
	self.active = false
	self.moving = true
	self.position = 1

	self.pattern_time = -ENTER_TIME
	self.step = 1
	self.phase = 1

	self:setRenderer(prox.Sprite("data/images/shiva_arm_left.png", 18, 23))

	if self.side == ShivaArm.static.SIDE_LEFT then
		self.x = 25
	elseif self.side == ShivaArm.static.SIDE_RIGHT then
		self.x = settings.screen_width - 25
		self:getRenderer():setScale(-1, 1)
	end

	prox.timer.tween(ENTER_TIME, self, {y = 170}, "out-sine",
		function()
			self.active = true
			self.moving = false
		end
	)
end

function ShivaArm:update(dt, rt)
	if self.moving == false then
		self.moving = true
		self.position = self.position % #positions + 1
		local desty = positions[self.position]
		self.tween = prox.timer.tween(3, self, {y = desty}, "in-out-quad", function() self.moving = false end)
	end

	if self.active then
		self.pattern_time = self.pattern_time + dt
		if self.pattern_time > patterns[self.phase][self.step][1] then
			local command = patterns[self.phase][self.step][2]
			if command == "shoot" then
				self:shoot()
			elseif command == "wait" then
			else
				error("Unknown Shiva arm pattern command.")
			end

			self.step = self.step + 1
			if self.step > #patterns[self.phase] then
				self.pattern_time = 0
				self.step = 1
			end
		end
	end
end

function ShivaArm:shoot()
	if self.side == ShivaArm.static.SIDE_LEFT then
		self:getScene():add(Bullet(self.x+21, self.y+14, 0, Bullet.static.TYPE_ENEMY_BULLET))
		self:getScene():add(Flash(self.x+21, self.y+14))
	else
		self:getScene():add(Bullet(self.x-14, self.y+18, math.pi, Bullet.static.TYPE_ENEMY_BULLET))
		self:getScene():add(Flash(self.x-14, self.y+18))
	end
end

function ShivaArm:kill()
	self.active = false
	prox.timer.cancel(self.tween)
end

return ShivaArm

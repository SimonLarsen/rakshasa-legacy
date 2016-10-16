local EnemyBullet = require("game.EnemyBullet")
local Flash = require("game.Flash")

local AgniHand = class("game.AgniHand", prox.Entity)

local ENTER_TIME = 3
local SHOT_COUNT = 6

AgniHand.static.SIDE_LEFT  = 1
AgniHand.static.SIDE_RIGHT = 2

local patterns = {
	[1] = {
		{0.0, "shoot"},
		{2.0, "wait"}
	},
	[2] = {
		{0.0, "shoot"},
		{4.0, "wait"}
	}
}

local positions = {
	[1] = {
		{100, 425},
		{25, 312},
		{85, 200},
		{85, 200},
		{100, 425}
	},
	[2] = {
		{220, 425},
		{295, 312},
		{295, 312},
		{245, 200},
		{245, 200}
	}
}

function AgniHand:enter(side)
	self.side = side
	self.rage = false
	self.moving = true
	self.position = 1
	self.y = -30

	self.pattern_time = 0
	self.step = 1
	self.phase = 1

	self:setRenderer(prox.Sprite("data/images/agni_hand.png", 22, 26))

	if self.side == AgniHand.static.SIDE_LEFT then
		self.x = settings.screen_width/2 - 75
		self.pattern_time = -1.0
	else
		self.x = settings.screen_width/2 + 75
		self:getRenderer():setScale(-1, 1)
	end

	prox.timer.tween(ENTER_TIME, self, {y = 193}, "out-sine",
		function()
			self.active = true
		end
	)
end

function AgniHand:update(dt, rt)
	if self.active then
		if self.moving == false then
			self.moving = true
			self.position = self.position % #positions[self.side] + 1
			local destx = positions[self.side][self.position][1]
			local desty = positions[self.side][self.position][2]
			self.hand_tween = prox.timer.tween(2, self, {x = destx, y = desty}, "in-out-quad", function() self.moving = false end)
		end

		self.pattern_time = self.pattern_time + dt
		if self.pattern_time > patterns[self.phase][self.step][1] then
			local command = patterns[self.phase][self.step][2]
			if command == "shoot" then
				self:shoot()
			elseif command == "wait" then
			else
				error("Unknown Agni hand pattern command.")
			end

			self.step = self.step + 1
			if self.step > #patterns[self.phase] then
				self.pattern_time = 0
				self.step = 1
			end
		end
	end
end

function AgniHand:shoot()
	self.player_chain = self:getScene():find("chain")
	local radius = 16

	local xdist = self.player_chain.x - self.x
	local ydist = self.player_chain.y - self.y
	local dir = math.atan2(ydist, xdist)

	for i=1, SHOT_COUNT do
		local offx = love.math.random(-radius, radius)
		local offy = love.math.random(-radius, radius)
		self:getScene():add(EnemyBullet(self.x+offx, self.y+offy, dir, EnemyBullet.static.TYPE_BALL))
	end
	self:getScene():add(Flash(self.x, self.y))
end

function AgniHand:onRage()
	self.moving = false

	self.pattern_time = 0
	self.step = 1
	self.phase = 2
	if self.side == AgniHand.static.SIDE_RIGHT then
		self.pattern_time = -2
	end
end

function AgniHand:kill()
	self.active = false
	prox.timer.cancel(self.hand_tween)
end

return AgniHand

local Boss = require("game.Boss")
local Bullet = require("game.Bullet")
local Flash = require("game.Flash")
local Explosion = require("game.Explosion")
local WhiteFlash = require("game.WhiteFlash")
local ShivaChain = require("game.ShivaChain")
local ShivaArm = require("game.ShivaArm")

local BossShiva = class("game.BossShiva", Boss)

local MAX_HEALTH = 300
local ENTER_TIME = 3
local EXPLOSION_DELAY = 0.5

BossShiva.static.STATE_ENTER     = 1
BossShiva.static.STATE_CALM      = 2
BossShiva.static.STATE_RAGE      = 3
BossShiva.static.STATE_EXPLODING = 4

local patterns = {
	[1] = {
		{0.25, "head"},
		{2.75, "head"},
		{3.00, "wait"}
	}
}

local positions = {
	160, 110, 160, 210
}

function BossShiva:enter()
	Boss.enter(self, "shiva", MAX_HEALTH)
	self:setName("shiva")

	self.x = settings.screen_width / 2
	self.y = -80
	self.moving = false
	self.position = 1

	self.pattern_time = -ENTER_TIME
	self.step = 1
	self.phase = 1

	self.state = BossShiva.static.STATE_ENTER

	self.chain = self:getScene():add(ShivaChain())
	self.arm_left = self:getScene():add(ShivaArm(ShivaArm.static.SIDE_LEFT))
	self.arm_right = self:getScene():add(ShivaArm(ShivaArm.static.SIDE_RIGHT))

	prox.timer.tween(ENTER_TIME, self, {y = 120}, "out-sine",
		function()
			self.state = BossShiva.static.STATE_CALM
			self.active = true
			self:getScene():find("hexgrid"):fillAll(0.4)
			self:getScene():find("screenshaker"):shake(0.5, 4, 60)
		end
	)

	self:setRenderer(prox.Animation("data/animations/shiva_base.lua"))
	self:setCollider(prox.BoxCollider(54, 54))

	self.player_chain = self:getScene():find("chain")
end

function BossShiva:update(dt, rt)
	Boss.update(self, dt, rt)
	
	if self.state == BossShiva.static.STATE_CALM then
		if self.moving == false then
			self.moving = true
			self.position = self.position % #positions + 1
			local destx = positions[self.position]
			self.head_tween = prox.timer.tween(3, self, {x = destx}, "in-out-quad", function() self.moving = false end)
		end

		if self.health < self.max_health/2 then
			self.state = BossShiva.static.STATE_RAGE

			self.pattern_time = -ENTER_TIME
			self.step = 1
			self.phase = 1

			self:getScene():find("hexgrid"):fillAll(0.3)
			self:getScene():find("screenshaker"):shake(0.4, 4, 60)

			self.arm_left.rage = true
			self.arm_right.rage = true
			self.arm_left.position = self.arm_left.position % 4 + 1
		end

	elseif self.state == BossShiva.static.STATE_RAGE then
		if self.moving == false then
			self.moving = true
			self.position = self.position % #positions + 1
			local destx = positions[self.position]
			self.head_tween = prox.timer.tween(1.5, self, {x = destx}, "out-linear", function() self.moving = false end)
		end
	
	elseif self.state == BossShiva.static.STATE_EXPLODING then
		if self.moving == false then
			self.moving = true
			local x = love.math.random(self.x - 60, self.x + 60)
			local y = love.math.random(self.y - 38, self.y + 30)
			self:getScene():add(Explosion(x, y, Explosion.static.SIZE_LARGE))
			prox.timer.after(EXPLOSION_DELAY, function() self.moving = false end)
		end
	end

	if self.active then
		self.pattern_time = self.pattern_time + dt
		if self.pattern_time > patterns[self.phase][self.step][1] then
			local command = patterns[self.phase][self.step][2]
			if command == "head" then
				self:shoot()
			elseif command == "wait" then
			else
				error("Unknown Shiva pattern command.")
			end

			self.step = self.step + 1
			if self.step > #patterns[self.phase] then
				self.pattern_time = 0
				self.step = 1
			end
		end
	end

	self.chain.head_x = self.x
	self.chain.y = self.y
	self.chain.arm_left_y = self.arm_left.y
	self.chain.arm_right_y = self.arm_right.y
end

function BossShiva:shoot()
	local gunx, guny, xdist, ydist, dir

	gunx = self.x + 25
	guny = self.y + 35
	xdist = self.player_chain.x - gunx
	ydist = self.player_chain.y - guny
	dir = math.atan2(ydist, xdist)
	self:getScene():add(Bullet(gunx, guny, dir, Bullet.static.TYPE_ENEMY_BULLET))
	self:getScene():add(Flash(gunx, guny))

	gunx = self.x - 25
	guny = self.y + 35
	xdist = self.player_chain.x - gunx
	ydist = self.player_chain.y - guny
	dir = math.atan2(ydist, xdist)
	self:getScene():add(Bullet(gunx, guny, dir, Bullet.static.TYPE_ENEMY_BULLET))
	self:getScene():add(Flash(gunx, guny))
end

function BossShiva:kill()
	for i,v in ipairs(self:getScene():findAll("bullet")) do
		if not v:isPlayerBullet() then
			v:kill()
		end
	end

	self.active = false
	self.moving = false
	self.state = BossShiva.static.STATE_EXPLODING
	self.arm_left:kill()
	self.arm_right:kill()
	self:getScene():find("screenshaker"):shake(4, 3, 60)
	prox.timer.cancel(self.head_tween)

	prox.timer.after(3, function()
		self.chain:remove()
		self.arm_left:remove()
		self.arm_right:remove()
		self:getScene():add(WhiteFlash(1, "in-linear"))
		self:dropGems()
		self:remove()
	end)
end

function BossShiva:getGems()
	return 30
end

return BossShiva

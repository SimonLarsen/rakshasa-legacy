local Boss = require("game.Boss")
local Bullet = require("game.Bullet")
local Explosion = require("game.Explosion")
local WhiteFlash = require("game.WhiteFlash")
local Gem = require("game.Gem")
local AgniHand = require("game.AgniHand")
local AgniGears = require("game.AgniGears")

local BossAgni = class("game.BossAgni", Boss)

local MAX_HEALTH = 400
local ENTER_TIME = 3
local EXPLOSION_DELAY = 0.5

BossAgni.static.STATE_ENTER     = 1
BossAgni.static.STATE_CALM      = 2
BossAgni.static.STATE_RAGE      = 3
BossAgni.static.STATE_EXPLODING = 4

local positions = {
	120, 200
}

function BossAgni:enter()
	Boss.enter(self, "Agni", MAX_HEALTH)
	self:setName("Agni")

	self.x = settings.screen_width / 2
	self.y = -40
	self.state = BossAgni.static.STATE_ENTER

	self.moving = false
	self.position = 1

	self.hand_left = self:getScene():add(AgniHand(AgniHand.static.SIDE_LEFT))
	self.hand_right = self:getScene():add(AgniHand(AgniHand.static.SIDE_RIGHT))
	self.gears = self:getScene():add(AgniGears())

	prox.timer.tween(ENTER_TIME, self, {y = 140}, "out-sine",
		function()
			self.state = BossAgni.static.STATE_CALM
			self.active = true
			self:getScene():find("hexlife"):fillAll(0.4)
			self:getScene():find("screenshaker"):shake(0.5, 4, 60)
		end
	)

	self:setRenderer(prox.Animation("data/animations/agni_head.lua"))
	self:setCollider(prox.BoxCollider(54, 54))

	self.player_chain = self:getScene():find("chain")
end

function BossAgni:update(dt, rt)
	Boss.update(self, dt, rt)

	if self.state == BossAgni.static.STATE_CALM then
		if self.moving == false then
			self.moving = true
			self.position = self.position % #positions + 1
			local destx = positions[self.position]
			self.head_tween = prox.timer.tween(4, self, {x = destx}, "in-out-quad", function() self.moving = false end)
		end

		if self.health < 0.75*self.max_health then
			self.state = BossAgni.static.STATE_RAGE

			self.pattern_time = -ENTER_TIME
			self.step = 1
			self.phase = 1

			self:getScene():find("hexlife"):fillAll(0.3)
			self:getScene():find("screenshaker"):shake(0.4, 4, 60)

			self.hand_left:onRage()
			self.hand_right:onRage()
		end

		self.hand_left.x = self.x - 75
		self.hand_right.x = self.x + 75

	elseif self.state == BossAgni.static.STATE_RAGE then
		if self.moving == false then
			self.moving = true
			self.position = self.position % #positions + 1
			local destx = positions[self.position]
			self.head_tween = prox.timer.tween(4, self, {x = destx}, "in-out-quad", function() self.moving = false end)
		end
	end

	self.gears.agni_head_x = self.x
	self.gears.agni_head_y = self.y
	self.gears.agni_hand_left_x = self.hand_left.x
	self.gears.agni_hand_left_y = self.hand_left.y
	self.gears.agni_hand_right_x = self.hand_right.x
	self.gears.agni_hand_right_y = self.hand_right.y
end

function BossAgni:kill()
	for i,v in ipairs(self:getScene():findAll("bullet")) do
		if not v:isPlayerBullet() then
			v:kill()
		end
	end

	self.active = false
	self.moving = false
	self.state = BossAgni.static.STATE_EXPLODING
	self.hand_left:kill()
	self.hand_right:kill()

	prox.timer.cancel(self.head_tween)
	self:getScene():find("screenshaker"):shake(4, 3, 60)

	prox.timer.after(3, function()
		self:remove()
		self.hand_left:remove()
		self.hand_right:remove()
		self.gears:remove()
		self:getScene():add(WhiteFlash(1, "in-linear"))
		self:dropGems()
	end)
end

function BossAgni:dropGems()
	local gems = self:getGems()
	local radius = 32
	for i=0, gems-1 do
		local angle = i / gems * 2*math.pi
		local x = self.x + math.cos(angle) * radius
		local y = self.y + math.sin(angle) * radius
		self:getScene():add(Gem(x, y))
	end
end

function BossAgni:getGems()
	return 50
end

return BossAgni

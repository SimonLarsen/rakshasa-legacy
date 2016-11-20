local Boss = require("game.Boss")
local Explosion = require("game.Explosion")
local AgniHand = require("game.bosses.AgniHand")
local AgniGears = require("game.bosses.AgniGears")

local Agni = class("game.bosses.Agni", Boss)

local MAX_HEALTH = 400
local ENTER_TIME = 3
local EXPLOSION_DELAY = 0.5

Agni.static.STATE_ENTER     = 1
Agni.static.STATE_CALM      = 2
Agni.static.STATE_RAGE      = 3
Agni.static.STATE_EXPLODING = 4

local positions = {
	120, 200
}

function Agni:enter()
	Boss.enter(self, "agni", MAX_HEALTH)
	self:setName("agni")

	self.x = settings.screen_width / 2
	self.y = -40
	self.state = Agni.static.STATE_ENTER

	self.moving = false
	self.position = 1

	self.hand_left = self:getScene():add(AgniHand(AgniHand.static.SIDE_LEFT))
	self.hand_right = self:getScene():add(AgniHand(AgniHand.static.SIDE_RIGHT))
	self.gears = self:getScene():add(AgniGears())

	prox.timer.tween(ENTER_TIME, self, {y = 140}, "out-sine",
		function()
			self.state = Agni.static.STATE_CALM
			self.active = true
			self:getScene():find("hexgrid"):fillAll(0.4)
			self:getScene():find("screenshaker"):shake(0.5, 4, 60)
		end
	)

	self:setRenderer(prox.Animation("data/animations/bosses/agni_head.lua"))
	self:setCollider(prox.BoxCollider(54, 54))

	self.player_chain = self:getScene():find("chain")
	self.sfx_explosion1 = prox.resources.getSound("data/sounds/explosion1.wav")
end

function Agni:update(dt, rt)
	Boss.update(self, dt, rt)

	if self.state == Agni.static.STATE_CALM then
		if self.moving == false then
			self.moving = true
			self.position = self.position % #positions + 1
			local destx = positions[self.position]
			self.head_tween = prox.timer.tween(4, self, {x = destx}, "in-out-quad", function() self.moving = false end)
		end

		if self.health < 0.75*self.max_health then
			self.state = Agni.static.STATE_RAGE

			self.pattern_time = -ENTER_TIME
			self.step = 1
			self.phase = 1

			self:getScene():find("hexgrid"):fillAll(0.3)
			self:getScene():find("screenshaker"):shake(0.4, 4, 60)

			self.hand_left:onRage()
			self.hand_right:onRage()
		end

		self.hand_left.x = self.x - 75
		self.hand_right.x = self.x + 75

	elseif self.state == Agni.static.STATE_RAGE then
		if self.moving == false then
			self.moving = true
			self.position = self.position % #positions + 1
			local destx = positions[self.position]
			self.head_tween = prox.timer.tween(4, self, {x = destx}, "in-out-quad", function() self.moving = false end)
		end

	elseif self.state == Agni.static.STATE_EXPLODING then
		if self.moving == false then
			self.moving = true
			local x = love.math.random(self.x - 60, self.x + 60)
			local y = love.math.random(self.y - 38, self.y + 30)
			self:getScene():add(Explosion(x, y, Explosion.static.SIZE_LARGE))
			prox.timer.after(EXPLOSION_DELAY, function() self.moving = false end)
			self.sfx_explosion1:play()
		end
	end

	self.gears.agni_head_x = self.x
	self.gears.agni_head_y = self.y
	self.gears.agni_hand_left_x = self.hand_left.x
	self.gears.agni_hand_left_y = self.hand_left.y
	self.gears.agni_hand_right_x = self.hand_right.x
	self.gears.agni_hand_right_y = self.hand_right.y
end

function Agni:kill()
	Boss.kill(self)

	self.active = false
	self.moving = false
	self.state = Agni.static.STATE_EXPLODING
	self.hand_left:kill()
	self.hand_right:kill()

	prox.timer.cancel(self.head_tween)
	self:getScene():find("screenshaker"):shake(4, 3, 60)

	prox.timer.after(3, function()
		self.hand_left:remove()
		self.hand_right:remove()
		self.gears:remove()
		self:purge()
	end)
end

function Agni:getGems()
	return 50
end

return Agni

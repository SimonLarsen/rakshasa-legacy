local Boss = require("game.Boss")
local DurgaShield = require("game.DurgaShield")
local DurgaChain = require("game.DurgaChain")
local EnemyBullet = require("game.EnemyBullet")
local Explosion = require("game.Explosion")
local Flash = require("game.Flash")

local BossDurga = class("game.BossDurga", Boss)

local MAX_HEALTH = 300
local ENTER_TIME = 2
local EXPLOSION_DELAY = 0.5

local SHIELD_OFFSET_CLOSED = 42
local SHIELD_OFFSET_OPEN = 86

BossDurga.static.STATE_ENTER     = 1
BossDurga.static.STATE_CLOSED    = 2
BossDurga.static.STATE_OPEN      = 3
BossDurga.static.STATE_EXPLODING = 4

local patterns = {
	[1] = {
		{1.0, "outer"}, {1.3, "outer"}, {1.6, "outer"}, {1.9, "outer"}, {2.2, "outer"},
		{3.2, "inner"}, {4.2, "inner"}, {5.2, "inner"}, {6.2, "inner"}
	},
	[2] = {
		{1.0, "inner"}, {2.0, "inner"}, {3.0, "inner"},
		{3.5, "outer"}, {3.7, "outer"},
		{4.5, "mouth"}, {4.6, "mouth"}, {4.7, "mouth"}, {4.8, "mouth"}, {5.0, "wait"}
	},
	[3] = {
		{1.0, "outer"}, {1.3, "outer"}, {1.6, "outer"}, {1.9, "outer"}, {2.2, "outer"}, {2.5, "outer"}, {2.8, "outer"},
		{4.0, "inner"}, {5.0, "inner"}, {6.0, "inner"}, {7.0, "inner"}
	},
	[4] = {
		{0.6, "mouth"}, {0.8, "mouth"}, {1.0, "mouth"}, {1.2, "mouth"}, {1.4, "mouth"},
		{2.1, "inner"}, {2.6, "inner"},
		{3.1, "mouth"}, {3.3, "mouth"}, {3.5, "mouth"}, {3.7, "mouth"}, {3.9, "mouth"},
		{4.6, "outer"}, {4.8, "outer"}
	}
}

local head_positions = {
	0, -48, 0, 48
}

function BossDurga:enter()
	Boss.enter(self, "durga", MAX_HEALTH)
	self:setName("durga")

	self.x = settings.screen_width / 2
	self.y = -80

	self.moving = false
	self.moving_head = false
	self.pattern_time = -ENTER_TIME
	self.step = 1
	self.phase = 1

	self.state = BossDurga.static.STATE_ENTER

	self:setRenderer(prox.Sprite("data/images/durga_head_idle.png"))
	self:setCollider(prox.BoxCollider(54, 54))

	self.head_offset = 0
	self.head_position = 1
	self.shield_offset = SHIELD_OFFSET_CLOSED
	self.shield_left = self:getScene():add(DurgaShield(DurgaShield.static.SIDE_LEFT))
	self.shield_right = self:getScene():add(DurgaShield(DurgaShield.static.SIDE_RIGHT))
	self.chain = self:getScene():add(DurgaChain(self.x, self.y, self.head_offset, self.shield_offset))

	prox.timer.tween(ENTER_TIME, self, {y = 140}, "out-sine",
		function()
			self.state = BossDurga.static.STATE_CLOSED
			self.active = true
			self:getScene():find("hexgrid"):fillAll(0.4)
			self:getScene():find("screenshaker"):shake(0.5, 4, 60)

			local destx = love.math.random(0,1) == 0 and 85 or 235
			self.moving = true

			self.shield_left:setVulnerable(true)
			self.shield_right:setVulnerable(true)
			prox.timer.tween(2, self, {x = destx}, "in-out-quad", function() self.moving = false end)
		end
	)

	self.sfx_explosion1 = prox.resources.getSound("data/sounds/explosion1.wav")
	self.sfx_explosion3 = prox.resources.getSound("data/sounds/explosion3.wav")
end

function BossDurga:update(dt, rt)
	Boss.update(self, dt, rt)

	if self.state == BossDurga.static.STATE_CLOSED then
		if self.moving == false then
			self.moving = true
			local destx = self.x < 160 and 235 or 85
			prox.timer.tween(3, self, {x = destx}, "in-out-quad", function() self.moving = false end)
		end
		
		self.head_offset = prox.math.movetowards(self.head_offset, 0, dt*100)

		if self.phase == 1 and self.health < 3*self.max_health/4
		or self.phase == 3 and self.health < self.max_health/4 then
			self.state = BossDurga.static.STATE_OPEN
			self.phase = self.phase + 1
			self.pattern_time = 0
			self.step = 1
			self.head_position = 1
			self.shield_left:setVulnerable(false)
			self.shield_right:setVulnerable(false)
			self:getScene():add(Explosion(self.shield_left.x-20, self.shield_left.y+4, Explosion.static.SIZE_LARGE))
			self:getScene():add(Explosion(self.shield_right.x+20, self.shield_right.y+4, Explosion.static.SIZE_LARGE))
			self.sfx_explosion3:play()
			self:getScene():find("screenshaker"):shake(0.5, 4, 60)

			self.shield_tween = prox.timer.tween(2, self, {shield_offset = SHIELD_OFFSET_OPEN}, "linear")
		end

	elseif self.state == BossDurga.static.STATE_OPEN then
		if self.moving == false then
			self.moving = true
			local destx = self.x < 160 and 180 or 140
			prox.timer.tween(4, self, {x = destx}, "in-out-quad", function() self.moving = false end)
		end

		if self.moving_head == false then
			self.moving_head = true
			self.head_position = self.head_position % #head_positions + 1
			local destx = head_positions[self.head_position]
			self.head_tween = prox.timer.tween(2, self, {head_offset = destx}, "in-out-quad")
			prox.timer.after(2.5, function() self.moving_head = false end)
		end

		if self.phase == 2 and self.health < self.max_health/2 then
			self.state = BossDurga.static.STATE_CLOSED
			self.phase = self.phase + 1
			self.pattern_time = 0
			self.step = 1
			self:getScene():add(Explosion(self.x+self.head_offset, self.y, Explosion.static.SIZE_LARGE))
			self.sfx_explosion3:play()
			self:getScene():find("screenshaker"):shake(0.5, 4, 60)

			prox.timer.cancel(self.head_tween)
			self.shield_tween = prox.timer.tween(2, self, {shield_offset = SHIELD_OFFSET_CLOSED}, "linear",
				function()
					self.shield_left:setVulnerable(true)
					self.shield_right:setVulnerable(true)
				end
			)
		end
	
	elseif self.state == BossDurga.static.STATE_EXPLODING then
		if self.moving == false then
			self.moving = true
			local x = love.math.random(self.x - 100, self.x + 100)
			local y = love.math.random(self.y - 24, self.y + 70)
			self:getScene():add(Explosion(x, y, Explosion.static.SIZE_LARGE))
			self.sfx_explosion1:play()
			prox.timer.after(EXPLOSION_DELAY, function() self.moving = false end)
		end
	end

	self.shield_left.x = math.ceil(self.x - self.shield_offset)
	self.shield_right.x = math.ceil(self.x + self.shield_offset-1)
	self.shield_left.y = self.y + 35
	self.shield_right.y = self.y + 35
	self.chain.x = self.x
	self.chain.y = self.y
	self.chain.shield_offset = self.shield_offset
	self.chain.head_offset = self.head_offset

	if self.active then
		self.pattern_time = self.pattern_time + dt
		if self.pattern_time > patterns[self.phase][self.step][1] then
			local command = patterns[self.phase][self.step][2]
			if command == "outer" then
				self.shield_left:shootOuter()
				self.shield_right:shootOuter()
			elseif command == "inner" then
				self.shield_left:shootInner()
				self.shield_right:shootInner()
			elseif command == "mouth" then
				self:shoot()
			elseif command == "wait" then
			else
				error("Unknown Durga pattern command.")
			end

			self.step = self.step + 1
			if self.step > #patterns[self.phase] then
				self.pattern_time = 0
				self.step = 1
			end
		end
	end

	self:getRenderer().ox = 31 - self.head_offset
	self:getCollider().ox = self.head_offset
end

function BossDurga:shoot()
	self:getScene():add(EnemyBullet(self.x+self.head_offset, self.y+24, math.pi/2, EnemyBullet.static.TYPE_SALVO))
	self:getScene():add(Flash(self.x+self.head_offset, self.y+24))
end

function BossDurga:kill()
	Boss.kill(self)

	if self.shield_tween then
		prox.timer.cancel(self.shield_tween)
	end
	if self.head_tween then
		prox.timer.cancel(self.head_tween)
	end

	self.active = false
	self.state = BossDurga.static.STATE_EXPLODING
	self.moving = false
	self:getScene():find("screenshaker"):shake(4, 3, 60)

	prox.timer.after(3, function()
		self.shield_left:remove()
		self.shield_right:remove()
		self.chain:remove()
		self:purge()
	end)
end

function BossDurga:getGems()
	return 20
end

return BossDurga

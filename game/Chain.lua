local Chain = class("game.Chain", prox.Entity)

local MIN_DIST = 86
local SUPER_THRESHOLD = 0.1
local INVULNERABLE_TIME = 2
local FORCE = 4500

local POWER_LEVEL1_DIST = 0
local POWER_LEVEL2_DIST = 140
local POWER_LEVEL3_DIST = 220

Chain.static.STATE_ACTIVE = 1
Chain.static.STATE_DEAD  = 2

function Chain:enter(ship1, ship2)
	self:setName("chain")
	self.z = 2
	self.invulnerable = 0
	self.state = Chain.static.STATE_ACTIVE

	self.ship1 = ship1
	self.ship2 = ship2
	self.direction = 0

	self.center_sprite = prox.Sprite("data/images/chain_center.png")
	self.center_ring = prox.Sprite("data/images/chain_ring.png")
	self.chain_link = prox.Sprite("data/images/chain_link.png", 4, 4)
end

function Chain:update(dt, rt)
	-- Move center
	self.x = math.floor((self.ship1.x + self.ship2.x) / 2)
	self.y = math.floor((self.ship1.y + self.ship2.y) / 2)

	-- Move ships apart if too close
	local xdist = self.ship2.x - self.ship1.x
	local ydist = self.ship2.y - self.ship1.y
	local dist = math.sqrt(xdist^2 + ydist^2)

	if dist < MIN_DIST then
		self.ship1.xspeed = self.ship1.xspeed - xdist / dist * dt * FORCE
		self.ship1.yspeed = self.ship1.yspeed - ydist / dist * dt * FORCE

		self.ship2.xspeed = self.ship2.xspeed + xdist / dist * dt * FORCE
		self.ship2.yspeed = self.ship2.yspeed + ydist / dist * dt * FORCE
	end

	-- Update power level based on ship distance
	local power_level = 1
	if dist >= POWER_LEVEL3_DIST then power_level = 3
	elseif dist >= POWER_LEVEL2_DIST then power_level = 2 end
	self.ship1:setPowerLevel(power_level)
	self.ship2:setPowerLevel(power_level)

	-- Rotate center and gears
	self.direction = math.atan2(ydist, xdist)
	self.center_ring:setRotation(self.direction)
	self.ship1:setDirection(self.direction)
	self.ship2:setDirection(self.direction)
	self.ship1:getGearSprite():setRotation(dist / 48)
	self.ship2:getGearSprite():setRotation(dist / 48)

	-- Check collision with bullets
	self.invulnerable = self.invulnerable - dt
	hc_rect = HC.rectangle(0, 0, dist, 5)
	hc_rect:moveTo(self.x, self.y)
	hc_rect:setRotation(self.direction)

	for i,v in ipairs(self:getScene():findAll("bullet")) do
		if not v:isPlayerBullet() and hc_rect:collidesWith(v:getHCShape()) then
			if self.state == Chain.static.STATE_ACTIVE and self.invulnerable <= 0 then
				self.invulnerable = INVULNERABLE_TIME
				self:getScene():find("screenshaker"):shake(0.5, 8, 60)
				self:getScene():find("controller"):playerHit()
			end
			v:kill()
		end
	end
end

function Chain:draw()
	if self.invulnerable >= 0 and prox.time.getTime() % 0.15 < 0.075 then return end

	local xdist = (self.ship2.x - self.ship1.x) / 2
	local ydist = (self.ship2.y - self.ship1.y) / 2
	local dist = math.sqrt(xdist^2 + ydist^2)
	local count = dist / 9

	for i=0, count-1 do
		self.chain_link:draw(self.x + xdist * i / count, self.y + ydist * i / count)
		self.chain_link:draw(self.x - xdist * i / count, self.y - ydist * i / count)
	end

	self.center_ring:draw(self.x, self.y)
	self.center_sprite:draw(self.x, self.y)
end

function Chain:kill()
	self.state = Chain.static.STATE_DEAD
	self.invulnerable = 1000000
end

return Chain

local shaders = require("shaders")
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

	self.center_sprites = {
		prox.Sprite("data/images/chain_center1.png"),
		prox.Sprite("data/images/chain_center2.png"),
		prox.Sprite("data/images/chain_center3.png")
	}
	self.center_ring = prox.Sprite("data/images/chain_ring.png")
	self.center_flash = prox.Sprite("data/images/chain_center_flash.png")
	self.chain_link = prox.Sprite("data/images/chain_link2.png", 5, 5)
	self.center_flash_alpha = 0

	self.dissolve_shader = shaders.getShader("data/shaders/dissolve.lua")
	local filter_image = prox.resources.getImage("data/images/dissolve.png")
	filter_image:setWrap("repeat","repeat")
	self.dissolve_edge = 1.2
	self.dissolve_shader:send("filter", filter_image)
	self.dissolve_shader:send("edge", self.dissolve_edge)
	self.head_alpha = 0

	self:setCollider(prox.BoxCollider(26, 26))

	prox.timer.after(0.7, function()
		prox.timer.tween(1.5, self, {dissolve_edge = -0.5}, "in-linear")
	end)
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
	self.center_flash_alpha = self.center_flash_alpha - math.max(0, 2000*dt)
	local power_level = 1
	if dist >= POWER_LEVEL3_DIST then power_level = 3
	elseif dist >= POWER_LEVEL2_DIST then power_level = 2 end
	self.ship1:setPowerLevel(power_level)
	self.ship2:setPowerLevel(power_level)
	if power_level ~= self.power_level then
		self.power_level = power_level
		self.center_flash_alpha = 255
	end

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

	self.dissolve_shader:send("edge", self.dissolve_edge)
end

function Chain:draw()
	if self.state == Chain.static.STATE_ACTIVE
	and self.invulnerable >= 0
	and prox.time.getTime() % 0.15 < 0.075 then
		return
	end

	local xdist = (self.ship2.x - self.ship1.x) / 2
	local ydist = (self.ship2.y - self.ship1.y) / 2
	local dist = math.sqrt(xdist^2 + ydist^2)
	local count = dist / 12

	if self.dissolve_edge > 0 then
		love.graphics.setShader(self.dissolve_shader)
	end

	for i=0, count-1 do
		self.chain_link:draw(self.x + xdist * i / count, self.y + ydist * i / count)
		self.chain_link:draw(self.x - xdist * i / count, self.y - ydist * i / count)
	end

	love.graphics.setShader()

	if self.invulnerable >= 0
	and prox.time.getTime() % 0.15 < 0.075 then
		return
	end

	self.center_ring:draw(self.x, self.y)
	self.center_sprites[self.power_level]:draw(self.x, self.y)

	if self.center_flash_alpha > 0 then
		love.graphics.setColor(255, 255, 255, math.max(0, self.center_flash_alpha))
		self.center_flash:draw(self.x, self.y)
		love.graphics.setColor(255, 255, 255, 255)
	end
end

function Chain:kill()
	self.state = Chain.static.STATE_DEAD
	self.invulnerable = 1000000
	prox.timer.tween(2.0, self, {dissolve_edge = 1.2}, "in-linear")
end

function Chain:onCollide(o)
	if o:getName() == "heart" then
		self:getScene():find("controller"):addScore(o:getPoints())
		self:getScene():find("controller"):addLives(1)
		o:remove()
	end
end

return Chain

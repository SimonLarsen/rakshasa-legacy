local BallFlash = require("game.BallFlash")
local Sword = require("game.Sword")
local EnemyBullet = require("game.EnemyBullet")
local BaseLaser = require("game.enemies.BaseLaser")

local Chain = class("game.Chain", prox.Entity)

local MIN_DIST = 86
local SUPER_THRESHOLD = 0.1
local INVULNERABLE_TIME = 3
local FORCE = 4500
local SHOOTING_COOLDOWN = 0.2

local SWORD_COST = 60

local PICKUP_RADIUS_BIG = 64
local PICKUP_RADIUS_SMALL = 32

local ENTER_TIME = 1.0

Chain.static.STATE_ENTER = 1
Chain.static.STATE_ACTIVE = 2
Chain.static.STATE_DEAD  = 3

function Chain:enter(ship1, ship2)
	self:setName("chain")
	self.z = 2
	self.invulnerable = 0
	self.state = Chain.static.STATE_ENTER

	self.ship1 = ship1
	self.ship2 = ship2
	self.direction = 0
	self.controller = self:getScene():find("controller")
	self.pickup_radius = 0

	self.center_ring = prox.Sprite("data/images/chain_ring.png")
	self.center_flash = prox.Sprite("data/images/chain_center_flash.png")
	self.link1 = prox.Sprite("data/images/link1.png", 5, 5)
	self.link2 = prox.Sprite("data/images/link2.png", 3, 3)

	self.face_anim = prox.Animator("data/animators/player_face.lua")

	self.dissolve_shader = prox.resources.getShader("data/shaders/dissolve.glsl")
	self.filter_image = prox.resources.getImage("data/images/textures/dissolve.png")
	self.filter_image:setWrap("repeat","repeat")
	self.dissolve_edge = 1.2
	self.center_flash_alpha = 0
	self.next_blink = 2*love.math.random() + 5
	self.shooting_cooldown = 0

	self:setCollider(prox.BoxCollider(26, 26))

	self.hc_rect = HC.rectangle(0, 0, 32, 8)
	self.hc_rect:moveTo(self.x, self.y)
	self.hc_rect:setRotation(self.direction)

	prox.timer.after(1.2, function()
		prox.timer.tween(0.4, self, {dissolve_edge = -0.5}, "in-linear")
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

	self.center_flash_alpha = self.center_flash_alpha - math.max(0, 2000*dt)

	-- Update face animator
	self.face_anim:update(dt, rt)
	self.next_blink = self.next_blink - dt
	if self.next_blink <= 0 then
		self.next_blink = 2*love.math.random() + 5
		self.face_anim:setProperty("blink", true)
	end

	self.pickup_radius = prox.math.movetowards(self.pickup_radius, PICKUP_RADIUS_BIG, dt*100)

	self.shooting_cooldown = self.shooting_cooldown - dt
	if self.ship1.cooldown > 0 or self.ship2.cooldown > 0 then
		self.shooting_cooldown = SHOOTING_COOLDOWN
		self.pickup_radius = prox.math.movetowards(self.pickup_radius, PICKUP_RADIUS_SMALL, dt*400)
	end
	self.face_anim:setProperty("shooting", self.shooting_cooldown > 0)

	-- Rotate center and gears
	self.direction = math.atan2(ydist, xdist)
	self.ship1:setDirection(self.direction)
	self.ship2:setDirection(self.direction)
	self.ship1:getGearSprite():setRotation(dist / 48)
	self.ship2:getGearSprite():setRotation(dist / 48)

	-- Check collision with bullets
	self.invulnerable = self.invulnerable - dt
	self.hc_rect = HC.rectangle(0, 0, dist, 8)
	self.hc_rect:moveTo(self.x, self.y)
	self.hc_rect:setRotation(self.direction)

	for i,v in ipairs(self:getScene():findAll(EnemyBullet)) do
		if v:getHCShape() and self.hc_rect:collidesWith(v:getHCShape()) then
			v:kill(self.invulnerable > 0)
			self:hit()
		end
	end

	-- Check collision with lasers
	for i,v in ipairs(self:getScene():findAll(BaseLaser)) do
		if v:getHCShape() and self.hc_rect:collidesWith(v:getHCShape()) then
			self:hit()
		end
	end
end

function Chain:hit()
	if self.invulnerable <= 0 then
		self.invulnerable = INVULNERABLE_TIME
		self:getScene():find("screenshaker"):shake(0.5, 8, 60)
		self.controller:playerHit()
		self.face_anim:setProperty("hurt", true)
		return true
	end
	return false
end

function Chain:draw()
	local xdist = (self.ship2.x - self.ship1.x) / 2
	local ydist = (self.ship2.y - self.ship1.y) / 2
	local dist = math.sqrt(xdist^2 + ydist^2)
	local count = dist / 10

	love.graphics.setColor(211, 80, 80, 80)
	love.graphics.circle("fill", math.floor(self.x+0.5), math.floor(self.y+0.5), self.pickup_radius)
	love.graphics.setColor(255, 255, 255, 255)

	if self.dissolve_edge > 0 then
		self.dissolve_shader:send("filter", self.filter_image)
		self.dissolve_shader:send("edge", self.dissolve_edge)
		love.graphics.setShader(self.dissolve_shader)
	end

	if self.invulnerable <= 0 or prox.time.getTime() % 0.15 > 0.075 then
		for i=0, count-1 do
			self.link1:draw(self.x + xdist * i / count, self.y + ydist * i / count)
			self.link1:draw(self.x - xdist * i / count, self.y - ydist * i / count)
		end

		for i=0, count-1 do
			self.link2:draw(self.x + xdist * (i+0.5) / count, self.y + ydist * (i+0.5) / count)
			self.link2:draw(self.x - xdist * (i+0.5) / count, self.y - ydist * (i+0.5) / count)
		end

	end
	love.graphics.setShader()

	self.center_ring:draw(self.x, self.y)

	if self.dissolve_edge > 0 then
		self.dissolve_shader:send("filter", self.filter_image)
		self.dissolve_shader:send("edge", self.dissolve_edge)
		love.graphics.setShader(self.dissolve_shader)
	end
	self.face_anim:draw(self.x, self.y)
	love.graphics.setShader()

	if self.center_flash_alpha > 0 then
		love.graphics.setColor(255, 255, 255, self.center_flash_alpha)
		self.center_flash:draw(self.x, self.y)
		love.graphics.setColor(255, 255, 255, 255)
	end
end

function Chain:sword()
	if self.controller:useGems(SWORD_COST) then
		local xdist = (self.ship2.x - self.ship1.x) / 2
		local ydist = (self.ship2.y - self.ship1.y) / 2
		local dist = math.sqrt(xdist^2 + ydist^2)
		local offx = math.cos(self.direction-math.pi/2)*20
		local offy = math.sin(self.direction-math.pi/2)*20
		self:getScene():add(Sword(self.x+offx, self.y+offy, self.direction-math.pi/2, dist))
		self.face_anim:setProperty("sword", true)
	end
end

function Chain:retract(side)
	if side == 1 then
		self.ship1:retract(self.x, self.y)
	else
		self.ship2:retract(self.x, self.y)
	end
end

function Chain:kill()
	self.state = Chain.static.STATE_DEAD
	self.invulnerable = 1000000
	prox.timer.tween(2.0, self, {dissolve_edge = 1.2}, "in-linear")
end

function Chain:onCollide(o)
	if o:getName() == "gem" then
		self.controller:addGems(o:getGems())
		self.flash = 0.05
		self.center_flash_alpha = 255
		o:pickup()
	end
end

function Chain:getHCShape()
	return self.hc_rect
end

function Chain:getPickupRadius()
	return self.pickup_radius
end

return Chain

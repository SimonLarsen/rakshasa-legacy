local Enemy = require("game.Enemy")
local EnemyBullet = require("game.EnemyBullet")
local Flash = require("game.Flash")

local Chaser = class("game.enemies.Chaser", Enemy)

local MAX_HEALTH = 6
local MOVE_SPEED = 40
local BULLET_COOLDOWN = 2.5

function Chaser:enter(properties)
	Enemy.enter(self, MAX_HEALTH)

	self.x = properties.x
	self.y = -25
	self.xspeed = 0
	self.yspeed = properties.speed or MOVE_SPEED
	self.player_chain = self:getScene():find("chain")
	self.cooldown = 2

	self:setRenderer(prox.Animation("data/animations/enemies/fighter.lua"))
	self:setCollider(prox.BoxCollider(32, 24))
end

function Chaser:update(dt, rt)
	dt, rt = Enemy.update(self, dt, rt)

	self.x = self.x + self.xspeed * dt
	self.y = self.y + self.yspeed * dt

	if self.y > prox.window.getHeight() + 25 then
		self:remove()
	end

	local xdist = self.player_chain.x - self.x
	if math.abs(xdist) > 24 then
		self.xspeed = prox.math.sign(xdist) * 150
	else
		self.xspeed = prox.math.movetowards(self.xspeed, 0, 400*dt)
	end

	self.cooldown = self.cooldown - dt
	if self.cooldown <= 0 then
		self.cooldown = BULLET_COOLDOWN
		self:shoot()
	end
end

function Chaser:getGems()
	return 4
end

function Chaser:shoot()
	self:getScene():add(EnemyBullet(self.x, self.y, math.pi/2))
	self:getScene():add(Flash(self.x, self.y))
end

return Chaser

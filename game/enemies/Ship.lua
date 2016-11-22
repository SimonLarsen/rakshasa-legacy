local Enemy = require("game.Enemy")
local EnemyBullet = require("game.EnemyBullet")
local Explosion = require("game.Explosion")
local Flash = require("game.Flash")

local Ship = class("game.Ship", Enemy)

Ship.static.STATE_ENTER = 1
Ship.static.STATE_IDLE  = 2
Ship.static.STATE_EXIT  = 3

local MAX_HEALTH = 2
local BULLET_COOLDOWN = 2.5

local SPEED = {
	[Ship.static.STATE_ENTER] = 300,
	[Ship.static.STATE_IDLE]  = 30,
	[Ship.static.STATE_EXIT]  = 200
}

local ACCELERATION = {
	[Ship.static.STATE_ENTER] = 150,
	[Ship.static.STATE_IDLE]  = 350,
	[Ship.static.STATE_EXIT]  = 200
}

function Ship:enter(properties)
	Enemy.enter(self, MAX_HEALTH)

	assert(#properties.points == 4, "Ship needs four point coordinates")
	self.points = properties.points
	self.x = self.points[1].x
	self.y = self.points[1].y

	self.state = Ship.static.STATE_ENTER
	self.time = 0
	self.speed = 100
	self.cooldown = 1.0

	self.player_chain = self:getScene():find("chain")

	self:setRenderer(prox.Animation("data/animations/enemies/ship.lua"))
	self:setCollider(prox.BoxCollider(32, 24))
end

function Ship:update(dt, rt)
	dt, rt = Enemy.update(self, dt, rt)

	--local destx = self.points[self.state+1].x
	local destx = self.x
	local desty = self.points[self.state+1].y

	self.speed = prox.math.movetowards(self.speed, SPEED[self.state], ACCELERATION[self.state]*dt)
	self.x, self.y = prox.math.movetowards2(self.x, self.y, destx, desty, self.speed*dt)
	local dist = math.sqrt((self.x - destx)^2 + (self.y - desty)^2)

	if dist < 0.5 then
		if self.state == Ship.static.STATE_EXIT then
			self:remove()
		else
			self.state = self.state + 1
		end
	end

	if self.state == Ship.static.STATE_IDLE then
		self.cooldown = self.cooldown - dt
		if self.cooldown <= 0 then
			self.cooldown = BULLET_COOLDOWN
			self:shoot()
		end
	end
end

function Ship:shoot()
	local xdist = self.player_chain.x - self.x
	local ydist = self.player_chain.y - self.y
	local dir = math.atan2(ydist, xdist)
	self:getScene():add(EnemyBullet(self.x, self.y, dir, EnemyBullet.static.TYPE_BALL))
	self:getScene():add(Flash(self.x, self.y))
end

function Ship:getGems()
	return 2
end

return Ship

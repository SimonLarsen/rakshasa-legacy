local Enemy = require("game.Enemy")
local EnemyBullet = require("game.EnemyBullet")
local Flash = require("game.Flash")

local Drone = class("game.Drone", Enemy)

local MAX_HEALTH = 1

local MOVE_SPEED = 180
local BULLET_COOLDOWN = 2.0

function Drone:enter(properties)
	Enemy.enter(self, MAX_HEALTH)

	assert(#properties.points >= 2, "Drone needs at least two points.")
	self.points = properties.points
	self.x = self.points[1].x
	self.y = self.points[1].y
	self.target = 2

	self.cooldown = 2
	self.player_chain = self:getScene():find("chain")

	self:setRenderer(prox.Animation("data/animations/enemies/drone.lua"))
	self:setCollider(prox.BoxCollider(26, 26))
end

function Drone:update(dt, rt)
	dt, rt = Enemy.update(self, dt, rt)

	local destx, desty = self.points[self.target].x, self.points[self.target].y
	self.x, self.y = prox.math.movetowards2(self.x, self.y, destx, desty, MOVE_SPEED*dt)
	local dist = math.sqrt((self.x - destx)^2 + (self.y - desty)^2)

	if dist < 0.5 then
		if self.target == #self.points then
			self:remove()
		else
			self.target = self.target + 1
		end
	end

	-- shooting disabled
	--[[
	self.cooldown = self.cooldown - dt
	if self.cooldown <= 0 then
		self.cooldown = BULLET_COOLDOWN
		self:shoot()
	end
	]]

	local rot = self:getRenderer().r
	self:getRenderer().r = rot - 2*dt
end

function Drone:shoot()
	local xdist = self.player_chain.x - self.x
	local ydist = self.player_chain.y - self.y
	local dir = math.atan2(ydist, xdist)
	self:getScene():add(EnemyBullet(self.x, self.y, dir, EnemyBullet.static.TYPE_BALL))
	self:getScene():add(Flash(self.x, self.y))
end

function Drone:onRemove()
	if self.timer then
		prox.timer.cancel(self.timer)
	end
end

function Drone:getGems()
	return 1
end

return Drone

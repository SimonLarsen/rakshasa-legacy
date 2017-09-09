local Enemy = require("game.Enemy")
local EnemyBullet = require("game.EnemyBullet")
local Flash = require("game.Flash")

local AimedDrone = class("game.enemies.AimedDrone", Enemy)

local MOVE_SPEED = 180
local MAX_HEALTH = 2

function AimedDrone:enter(properties)
	Enemy.enter(self, MAX_HEALTH)

	assert(#properties.points == 3, "AimedDrone needs exactly three points.")
	self.points = properties.points
	self.speed = properties.speed or MOVE_SPEED

	local xdist = self.points[2].x - self.points[1].x
	local ydist = self.points[2].y - self.points[1].y
	local dist = math.sqrt(xdist^2 + ydist^2)

	self.x = self.points[1].x
	self.y = self.points[1].y
	self.startx, self.starty = self.x, self.y
	self.xspeed = xdist / dist * self.speed
	self.yspeed = ydist / dist * self.speed
	self.shoot_dist = dist
	self.has_shot = false
	self.shoot_dir = math.atan2(self.points[3].y - self.points[2].y, self.points[3].x - self.points[2].x)
	self.dist = 0

	self:setRenderer(prox.Animation("data/animations/enemies/drone.lua"))
	self:setCollider(prox.BoxCollider(25, 25))
end

function AimedDrone:update(dt, rt)
	self.x = self.x + self.xspeed * dt
	self.y = self.y + self.yspeed * dt
	self.dist = self.dist + self.speed * dt

	if not self.has_shot and self.dist > self.shoot_dist then
		self:shoot()
		self.has_shot = true
	end

	if self.has_shot and (self.x < -32 or self.x > settings.screen_width + 32 or self.y < -32 or self.y > settings.screen_height + 32) then
		self:remove()
	end

	local rot = self:getRenderer():getRotation()
	self:getRenderer():setRotation(rot - 2*dt)
end

function AimedDrone:shoot()
	self:getScene():add(EnemyBullet(self.x, self.y, self.shoot_dir, EnemyBullet.static.TYPE_BALL))
	self:getScene():add(Flash(self.x, self.y))
end

function AimedDrone:getGems()
	return 1
end

return AimedDrone

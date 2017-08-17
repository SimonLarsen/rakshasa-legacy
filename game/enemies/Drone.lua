local BaseDrone = require("game.enemies.BaseDrone")
local EnemyBullet = require("game.EnemyBullet")
local Flash = require("game.Flash")

local Drone = class("game.enemies.Drone", BaseDrone)

local MOVE_SPEED = 170
local MAX_HEALTH = 2

function Drone:enter(properties)
	BaseDrone.enter(self, properties, MAX_HEALTH, MAX_SPEED)
end

function Drone:getAnimation()
	return prox.Animation("data/animations/enemies/drone.lua")
end

function Drone:getCollider()
	return prox.BoxCollider(25, 25)
end

function Drone:shoot()
	local xdist = self.player_chain.x - self.x
	local ydist = self.player_chain.y - self.y
	local dir = math.atan2(ydist, xdist)
	self:getScene():add(EnemyBullet(self.x, self.y, dir, EnemyBullet.static.TYPE_BALL))
	self:getScene():add(Flash(self.x, self.y))
end

function Drone:getGems()
	return 2
end

return Drone

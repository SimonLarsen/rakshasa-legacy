local BaseDrone = require("game.enemies.BaseDrone")
local EnemyBullet = require("game.EnemyBullet")
local Flash = require("game.Flash")

local Scout = class("game.enemies.Scout", BaseDrone)

local MAX_HEALTH = 1

function Scout:enter(properties)
	BaseDrone.enter(self, properties, MAX_HEALTH)
end

function Scout:getAnimation()
	return prox.Animation("data/animations/enemies/drone.lua")
end

function Scout:getCollider()
	return prox.BoxCollider(26, 26)
end

function Scout:shoot()
end

function Scout:getGems()
	return 1
end

return Scout

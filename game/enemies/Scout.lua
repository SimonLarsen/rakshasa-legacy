local BaseDrone = require("game.enemies.BaseDrone")
local EnemyBullet = require("game.EnemyBullet")
local Flash = require("game.Flash")

local Scout = class("game.enemies.Scout", BaseDrone)

local MOVE_SPEED = 180

function Scout:enter(properties)
	BaseDrone.enter(self, properties, MOVE_SPEED)
end

function Scout:getAnimation()
	return prox.Animation("data/animations/enemies/scout.lua")
end

function Scout:getCollider()
	return prox.BoxCollider(25, 25)
end

function Scout:shoot()
end

return Scout

local BaseFighter = require("game.enemies.BaseFighter")
local EnemyBullet = require("game.EnemyBullet")
local Flash = require("game.Flash")

local Fighter = class("game.enemies.Fighter", BaseFighter)

local SALVO_COOLDOWN = 2.5

function Fighter:enter(properties)
	BaseFighter.enter(self, properties, SALVO_COOLDOWN)
end

function Fighter:getAnimation()
	return prox.Animation("data/animations/enemies/fighter.lua")
end

function Fighter:getCollider()
	return prox.BoxCollider(32, 24)
end

function Fighter:shoot()
	self:getScene():add(EnemyBullet(self.x, self.y, math.pi/2))
	self:getScene():add(Flash(self.x, self.y))
end

return Fighter

local BaseFighter = require("game.enemies.BaseFighter")
local EnemyBullet = require("game.EnemyBullet")
local Flash = require("game.Flash")

local Viper = class("game.enemies.Viper", BaseFighter)

local MAX_HEALTH = 4

function Viper:enter(properties)
	BaseFighter.enter(self, properties, MAX_HEALTH)
end

function Viper:getAnimation()
	return prox.Animation("data/animations/enemies/fighter.lua")
end

function Viper:getCollider()
	return prox.BoxCollider(32, 24)
end

function Viper:shoot()
	self:getScene():add(EnemyBullet(self.x, self.y, math.pi/2-0.5, EnemyBullet.static.TYPE_LASER))
	self:getScene():add(EnemyBullet(self.x, self.y, math.pi/2, EnemyBullet.static.TYPE_LASER))
	self:getScene():add(EnemyBullet(self.x, self.y, math.pi/2+0.5, EnemyBullet.static.TYPE_LASER))
	self:getScene():add(Flash(self.x, self.y))
end

return Viper

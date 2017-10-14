local BaseFighter = require("game.enemies.BaseFighter")
local EnemyBullet = require("game.EnemyBullet")
local Flash = require("game.Flash")

local Viper = class("game.enemies.Viper", BaseFighter)

local SALVO_COOLDOWN = 3.5

function Viper:enter(properties)
	BaseFighter.enter(self, properties, SALVO_COOLDOWN)
end

function Viper:getAnimation()
	return prox.Animation("data/animations/enemies/viper.lua")
end

function Viper:getCollider()
	return prox.BoxCollider(32, 24)
end

function Viper:shoot()
	self:getScene():add(EnemyBullet(self.x, self.y, math.pi/2-0.5))
	self:getScene():add(EnemyBullet(self.x, self.y, math.pi/2))
	self:getScene():add(EnemyBullet(self.x, self.y, math.pi/2+0.5))
	self:getScene():add(Flash(self.x, self.y))
end

return Viper

local BaseFighter = require("game.enemies.BaseFighter")
local EnemyBullet = require("game.EnemyBullet")
local Flash = require("game.Flash")

local Bomber = class("game.enemies.Bomber", BaseFighter)

local MAX_HEALTH = 4

function Bomber:enter(properties)
	BaseFighter.enter(self, properties, MAX_HEALTH)
end

function Bomber:getAnimation()
	return prox.Animation("data/animations/enemies/fighter.lua")
end

function Bomber:getCollider()
	return prox.BoxCollider(32, 24)
end

function Bomber:shoot()
	self:getScene():add(EnemyBullet(self.x-6, self.y, math.pi/2+0.05,  EnemyBullet.static.TYPE_LASER))
	self:getScene():add(EnemyBullet(self.x+6, self.y, math.pi/2-0.05,  EnemyBullet.static.TYPE_LASER))
	self:getScene():add(EnemyBullet(self.x-3, self.y, math.pi/2+0.025, EnemyBullet.static.TYPE_LASER))
	self:getScene():add(EnemyBullet(self.x+3, self.y, math.pi/2-0.025, EnemyBullet.static.TYPE_LASER))
	self:getScene():add(EnemyBullet(self.x,   self.y, math.pi/2,       EnemyBullet.static.TYPE_LASER))
	self:getScene():add(Flash(self.x, self.y))
end

return Bomber

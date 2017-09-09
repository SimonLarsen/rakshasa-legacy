local BaseFighter = require("game.enemies.BaseFighter")
local EnemyBullet = require("game.EnemyBullet")
local Flash = require("game.Flash")

local Striker = class("game.enemies.Striker", BaseFighter)

local MAX_HEALTH = 5

function Striker:enter(properties)
	BaseFighter.enter(self, properties, MAX_HEALTH)
end

function Striker:getAnimation()
	return prox.Animation("data/animations/enemies/striker.lua")
end

function Striker:getCollider()
	return prox.BoxCollider(32, 24)
end

function Striker:shoot()
	self:getScene():add(EnemyBullet(self.x,   self.y, math.pi/2,      EnemyBullet.static.TYPE_LASER))
	self:getScene():add(EnemyBullet(self.x-3, self.y, math.pi/2+0.04, EnemyBullet.static.TYPE_LASER))
	self:getScene():add(EnemyBullet(self.x+3, self.y, math.pi/2-0.04, EnemyBullet.static.TYPE_LASER))
	self:getScene():add(EnemyBullet(self.x-6, self.y, math.pi/2+0.08, EnemyBullet.static.TYPE_LASER))
	self:getScene():add(EnemyBullet(self.x+6, self.y, math.pi/2-0.08, EnemyBullet.static.TYPE_LASER))
	self:getScene():add(Flash(self.x, self.y))
end

return Striker

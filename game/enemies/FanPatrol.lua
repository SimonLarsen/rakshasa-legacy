local EnemyBullet = require("game.EnemyBullet")
local Flash = require("game.Flash")
local Patrol = require("game.enemies.Patrol")

local FanPatrol = class("game.enemies.FanPatrol", Patrol)

local MAX_HEALTH = 17

function FanPatrol:enter(properties)
	Patrol.enter(self, properties, MAX_HEALTH)
end

function FanPatrol:shoot(dir)
	self:getScene():add(EnemyBullet(self.x,   self.y, dir))
	self:getScene():add(EnemyBullet(self.x-3, self.y, dir+0.05))
	self:getScene():add(EnemyBullet(self.x+3, self.y, dir-0.05))
	self:getScene():add(EnemyBullet(self.x-6, self.y, dir+0.10))
	self:getScene():add(EnemyBullet(self.x+6, self.y, dir-0.10))
	self:getScene():add(Flash(self.x,self.y))
end

function FanPatrol:getGems()
	return 7
end

return FanPatrol

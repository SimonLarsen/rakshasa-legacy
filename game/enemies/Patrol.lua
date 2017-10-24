local Enemy = require("game.Enemy")
local EnemyBullet = require("game.EnemyBullet")
local Flash = require("game.Flash")
local BasePatrol = require("game.enemies.BasePatrol")

local Patrol = class("game.enemies.Patrol", BasePatrol)

Patrol.static.STATE_ENTER = 1
Patrol.static.STATE_IDLE  = 2

function Patrol:enter(properties)
	BasePatrol.enter(self, properties)
end

function Patrol:shoot(dir)
	self:getScene():add(EnemyBullet(self.x, self.y, dir))
	self:getScene():add(Flash(self.x, self.y))
end

return Patrol

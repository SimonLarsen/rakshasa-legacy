local Enemy = require("game.Enemy")
local EnemyBullet = require("game.EnemyBullet")
local Flash = require("game.Flash")
local BasePatrol = require("game.enemies.BasePatrol")

local Patrol = class("game.enemies.Patrol", BasePatrol)

local MAX_HEALTH = 4
local ENTER_COOLDOWN = 1.0
local COOLDOWN = 5.0
local ENTER_TIME = 1.5

Patrol.static.STATE_ENTER = 1
Patrol.static.STATE_IDLE  = 2

function Patrol:enter(properties)
	BasePatrol.enter(self, properties, MAX_HEALTH)
end

function Patrol:shoot(dir)
	self:getScene():add(EnemyBullet(self.x, self.y, dir))
	self:getScene():add(Flash(self.x, self.y))
end

function Patrol:getGems()
	return 3
end

return Patrol

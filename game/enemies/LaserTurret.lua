local Enemy = require("game.Enemy")

local LaserTurret = class("game.LaserTurret", Enemy)

local MOVE_SPEED = 20

function LaserTurret:enter(x, y, dir, beam)
	self.x = x
	self.y = y
	self.beam = beam

	self:setRenderer("data/animations/enemies/laser_turret.lua")
	self:getRenderer().r = self.dir
end

function fname()
	
end

return LaserTurret

local Enemy = require("game.Enemy")

local Silo = class("game.Silo", Enemy)

local MAX_HEALTH = 4
local MOVE_SPEED = 100

function Silo:enter(properties)
	Enemy.enter(self, MAX_HEALTH, true)

	self.x = properties.points[1].x
	self.y = properties.points[1].y
	self.destx = properties.points[2].x
	self.desty = properties.points[2].y
	self.speed = properties.speed or MOVE_SPEED

	self:setRenderer(prox.Animation("data/animations/enemies/silo.lua"))
	self:setCollider(prox.BoxCollider(50, 24))
end

function Silo:update(dt, rt)
	dt, rt = Enemy.update(self, dt, rt)

	self.x, self.y = prox.math.movetowards2(self.x, self.y, self.destx, self.desty, self.speed*dt)
	local dist = math.sqrt((self.x - self.destx)^2 + (self.y - self.desty)^2)

	if dist < 0.5 then
		self:remove()
	end
end

function Silo:getGems()
	return 30
end

return Silo

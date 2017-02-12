local Enemy = require("game.Enemy")

local Silo = class("game.Silo", Enemy)

local MAX_HEALTH = 30
local MOVE_SPEED = 30

function Silo:enter(properties)
	Enemy.enter(self, MAX_HEALTH, true)

	self.x = properties.points[1].x
	self.y = properties.points[1].y

	self.destx = properties.points[2].x
	self.desty = properties.points[2].y

	self.sparkle = prox.Animation("data/animations/sparkle.lua")

	self:setRenderer(prox.MultiRenderer())
	self:getRenderer():addRenderer(prox.Animation("data/animations/enemies/silo.lua"))
	self:getRenderer():addRenderer(self.sparkle)
	self:setCollider(prox.BoxCollider(54, 54))
end

function Silo:update(dt, rt)
	dt, rt = Enemy.update(self, dt, rt)

	self.x, self.y = prox.math.movetowards2(self.x, self.y, self.destx, self.desty, MOVE_SPEED*dt)
	local dist = math.sqrt((self.x - self.destx)^2 + (self.y - self.desty)^2)

	if dist < 0.5 then
		self:remove()
	end

	if self.sparkle:isFinished() then
		local ox = love.math.random(-23, 23)
		local oy = love.math.random(-23, 23)
		self:getRenderer():setOffset(2, ox, oy)
		self.sparkle:reset()
	end
end

function Silo:getGems()
	return 10
end

return Silo

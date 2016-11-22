local Enemy = require("game.Enemy")

local Silo = class("game.Silo", Enemy)

local MAX_HEALTH = 30
local MOVE_SPEED = 30

function Silo:enter(properties)
	Enemy.enter(self, MAX_HEALTH, true)

	self.x = properties.x
	self.y = -30

	self:setRenderer(prox.Animation("data/animations/enemies/silo.lua"))
	self:setCollider(prox.BoxCollider(54, 54))
end

function Silo:update(dt, rt)
	dt, rt = Enemy.update(self, dt, rt)

	self.y = self.y + MOVE_SPEED * dt

	if self.y > prox.window.getHeight()+30 then
		self:remove()
	end
end

function Silo:getGems()
	return 10
end

return Silo

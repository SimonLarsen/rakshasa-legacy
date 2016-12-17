local Enemy = require("game.Enemy")

local Falcon = class("game.enemies.Falcon", Falcon)

local MAX_HEALTH = 40

local POSITIONS = {
	80, 160, 240, 160
}

function Falcon:enter(properties)
	Enemy.enter(self, MAX_HEALTH, true)

	self.destx = properties.x
	self.desty = properties.y
	self.x = self.destx
	self.y = -44
	self.entered = false

	self.enter_timer = prox.timer.tween(ENTER_TIME, self, {y=self.desty}, "out-quad", function() self.entered = true end)

	self:setRenderer(prox.Animation("data/animations/enemies/falcon.lua"))
	self:setCollider(prox.BoxCollider(80, 32))
end

function Falcon:update(dt, rt)
	dt, rt = Enemy.update(self, dt, rt)
end

function Falcon:onRemove()
	Enemy.onRemove(self)
	prox.timer.cancel(self.enter_timer)
end

function Falcon:getGems()
	return 15
end

return Falcon

local Heart = class("game.Heart", prox.Entity)

local ACCELERATION = 50
local SCROLL_SPEED = 100

function Heart:enter(x, y)
	self:setName("heart")
	self.x = x
	self.starty = y
	self.y = self.starty
	self.z = 4

	self:setCollider(prox.BoxCollider(20, 34))
	self:setRenderer(prox.Sprite("data/images/heart.png"))
end

function Heart:update(dt, rt)
	self.y = self.starty + math.cos(prox.time.getTime() * 2) * 8
end

return Heart

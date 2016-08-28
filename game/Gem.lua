local Gem = class("game.Gem", prox.Entity)

local ACCELERATION = 300
local SCROLL_SPEED = 240
local FOLLOW_SPEED = 300
local FOLLOW_RANGE = 32

Gem.static.STATE_FALL = 1
Gem.static.STATE_FOLLOW = 2

function Gem:enter(x, y)
	self:setName("gem")
	self.x = x
	self.y = y
	self.z = 5
	self.state = Gem.static.STATE_FALL

	self.xspeed = love.math.random(-10, 10)
	self.yspeed = -150 + love.math.random(-15, 15)

	self.ships = self:getScene():findAll("ship")

	self:setRenderer(prox.Sprite("data/images/gem" .. love.math.random(1,6) .. ".png"))
	self:setCollider(prox.BoxCollider(10, 10))
end

function Gem:update(dt, rt)
	if self.state == Gem.static.STATE_FALL then
		self.xspeed = prox.math.movetowards(self.xspeed, 0, 10*dt)
		self.yspeed = prox.math.cap(self.yspeed + ACCELERATION * dt, -1000, SCROLL_SPEED)

		self.x = self.x + self.xspeed * dt
		self.y = self.y + self.yspeed * dt

		for i,v in ipairs(self.ships) do
			local xdist = v.x - self.x
			local ydist = v.y - self.y
			local dist = math.sqrt(xdist^2 + ydist^2)

			if dist < 64 then
				self.state = Gem.static.STATE_FOLLOW
				self.following = v
			end
			break
		end

	elseif self.state == Gem.static.STATE_FOLLOW then
		local xdist = math.abs(self.x - self.following.x)
		local ydist = math.abs(self.y - self.following.y)
		local dist = math.sqrt(xdist^2 + ydist^2)

		self.x = prox.math.movetowards(self.x, self.following.x, xdist/dist*FOLLOW_SPEED*dt)
		self.y = prox.math.movetowards(self.y, self.following.y, ydist/dist*FOLLOW_SPEED*dt)
	end

	if self.y > prox.window.getHeight()+18 then
		self:remove()
	end
end

return Gem

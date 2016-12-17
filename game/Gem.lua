local Slowable = require("game.Slowable")

local Gem = class("game.Gem", Slowable)

local ACCELERATION = 300
local SCROLL_SPEED = 240
local FOLLOW_SPEED = 450
local FOLLOW_RANGE = 32

Gem.static.STATE_FALL = 1
Gem.static.STATE_FOLLOW = 2

function Gem:enter(x, y)
	Slowable.enter(self)
	self:setName("gem")
	self.x = x
	self.y = y
	self.z = 5
	self.state = Gem.static.STATE_FALL

	self.xspeed = love.math.random(-10, 10)
	self.yspeed = -150 + love.math.random(-15, 15)

	self.ships = self:getScene():findAll("ship")

	--[[
	self:setRenderer(prox.Sprite("data/images/gems/gem" .. love.math.random(1,5) .. ".png"))
	]]
	local anim = prox.Animation("data/animations/gem.lua")
	anim._frame = love.math.random(1, anim._frames)
	anim._time = love.math.random() * 0.04
	self:setRenderer(anim)
	self:setCollider(prox.BoxCollider(10, 10))
end

function Gem:update(dt, rt)
	dt, rt = Slowable.update(self, dt, rt)

	if self.state == Gem.static.STATE_FALL then
		self.xspeed = prox.math.movetowards(self.xspeed, 0, 10*dt)
		self.yspeed = prox.math.cap(self.yspeed + ACCELERATION * dt, -1000, SCROLL_SPEED)

		self.x = self.x + self.xspeed * dt
		self.y = self.y + self.yspeed * dt

		local min_dist = 100000
		local closest_ship = nil
		for i,v in ipairs(self.ships) do
			local xdist = v.x - self.x
			local ydist = v.y - self.y
			local dist = math.sqrt(xdist^2 + ydist^2)

			if dist < min_dist then
				min_dist = dist
				closest_ship = v
			end
		end
		if min_dist < 64 then
			self.state = Gem.static.STATE_FOLLOW
			self.following = closest_ship
		end

	elseif self.state == Gem.static.STATE_FOLLOW then
		local xdist = math.abs(self.x - self.following.x)
		local ydist = math.abs(self.y - self.following.y)
		local dist = math.sqrt(xdist^2 + ydist^2)

		self.x = prox.math.movetowards(self.x, self.following.x, xdist/dist*FOLLOW_SPEED*rt)
		self.y = prox.math.movetowards(self.y, self.following.y, ydist/dist*FOLLOW_SPEED*rt)
	end

	if self.y > prox.window.getHeight()+18 then
		self:remove()
	end
end

function Gem:getGems()
	return 1
end

return Gem

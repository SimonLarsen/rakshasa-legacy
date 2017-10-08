local Enemy = require("game.Enemy")
local Explosion = require("game.Explosion")

local BaseMine = class("game.enemies.BaseMine", Enemy)

local MAX_HEALTH = 10
local MOVE_SPEED = 45

function BaseMine:enter(properties)
	Enemy.enter(self, MAX_HEALTH)

	self.x = properties.x
	self.y = -25
	self.speed = properties.speed or MOVE_SPEED
	if properties.time then
		self.time = properties.time
	else
		self.time = (properties.y - self.y) / self.speed
	end
end

function BaseMine:update(dt, rt)
	dt, rt = Enemy.update(self, dt, rt)

	self.y = self.y + self.speed * dt
	self.time = self.time - dt

	if self.y > prox.window.getHeight() + 25 then
		self:remove()
	end

	if self.time <= 0 then
		self:getScene():add(Explosion(self.x, self.y, Explosion.static.SIZE_MEDIUM))
		self:getScene():find("screenshaker"):shake(0.4, 2, 60)
		self:shoot()
		self:remove()
		local sfx = prox.resources.getSound("data/sounds/explosion3.wav")
		sfx:play()
	end

	if self.time < 0.9 then
		self:getRenderer():setProperty("detonate", true)
	end

	if self.time < 3 and self.time > 1 and self.time % 0.5 < 0.25
	or self.time <= 1 and self.time % 0.25 < 0.125 then
		self:getRenderer():setShader(self.white_shader)
	end
	--[[
	if ydist < 150 and ydist > 50 and prox.time.getTime() % 0.5 < 0.25 
	or ydist < 50  and prox.time.getTime() % 0.25 < 0.125 then
	end
	]]
end

function BaseMine:getGems()
	return 3
end

return BaseMine

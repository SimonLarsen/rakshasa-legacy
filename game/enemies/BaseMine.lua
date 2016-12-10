local Enemy = require("game.Enemy")
local Explosion = require("game.Explosion")

local BaseMine = class("game.enemies.BaseMine", Enemy)

local MAX_HEALTH = 16
local MOVE_SPEED = 45

function BaseMine:enter(properties)
	Enemy.enter(self, MAX_HEALTH)

	self.x = properties.x
	self.y = -16
	self.ylimit = properties.y
end

function BaseMine:update(dt, rt)
	dt, rt = Enemy.update(self, dt, rt)

	self.y = self.y + MOVE_SPEED * dt

	if self.y > prox.window.getHeight() + 16 then
		self:remove()

	elseif self.y > self.ylimit then
		self:getScene():add(Explosion(self.x, self.y, Explosion.static.SIZE_MEDIUM))
		self:getScene():find("screenshaker"):shake(0.4, 2, 60)
		self:shoot()
		self:remove()
		local sfx = prox.resources.getSound("data/sounds/explosion3.wav")
		sfx:play()
	end

	local ydist = self.ylimit - self.y
	if ydist < 50 then
		self:getRenderer():setProperty("detonate", true)
	end

	if ydist < 150 and ydist > 50 and prox.time.getTime() % 0.5 < 0.25 
	or ydist < 50  and prox.time.getTime() % 0.25 < 0.125 then
		self:getRenderer():setShader(self.white_shader)
	end
end

function BaseMine:getGems()
	return 3
end

return BaseMine

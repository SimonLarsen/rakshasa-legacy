local Enemy = require("game.Enemy")
local Bullet = require("game.Bullet")
local Explosion = require("game.Explosion")

local EnemyMine = class("game.EnemyMine", Enemy)

local MAX_HEALTH = 10
local MOVE_SPEED = 45

function EnemyMine:enter(x, ylimit)
	Enemy.enter(self, MAX_HEALTH)

	self.x = x
	self.y = -16
	self.ylimit = ylimit

	self:setRenderer(prox.Animator("data/animators/enemy_mine.lua"))
	self:setCollider(prox.BoxCollider(28, 26))
end

function EnemyMine:update(dt, rt)
	Enemy.update(self, dt, rt)

	self.y = self.y + MOVE_SPEED * dt

	if self.y > prox.window.getHeight() + 16 then
		self:remove()

	elseif self.y > self.ylimit then
		self:getScene():add(Explosion(self.x, self.y, Explosion.static.SIZE_MEDIUM))
		self:getScene():find("screenshaker"):shake(0.4, 2, 60)
		for i=0,3 do
			self:getScene():add(Bullet(self.x, self.y, i*math.pi/2, Bullet.static.TYPE_ENEMY_BULLET))
		end
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

function EnemyMine:getGems()
	return 3
end

return EnemyMine

local Enemy = require("game.Enemy")
local EnemyBullet = require("game.EnemyBullet")
local Explosion = require("game.Explosion")

local Mine = class("game.Mine", Enemy)

local MAX_HEALTH = 10
local MOVE_SPEED = 45

function Mine:enter(x, ylimit)
	Enemy.enter(self, MAX_HEALTH)

	self.x = x
	self.y = -16
	self.ylimit = ylimit

	self:setRenderer(prox.Animator("data/animators/enemies/mine.lua"))
	self:setCollider(prox.BoxCollider(28, 26))
end

function Mine:update(dt, rt)
	dt, rt = Enemy.update(self, dt, rt)

	self.y = self.y + MOVE_SPEED * dt

	if self.y > prox.window.getHeight() + 16 then
		self:remove()

	elseif self.y > self.ylimit then
		self:getScene():add(Explosion(self.x, self.y, Explosion.static.SIZE_MEDIUM))
		self:getScene():find("screenshaker"):shake(0.4, 2, 60)
		for i=0,3 do
			self:getScene():add(EnemyBullet(self.x, self.y, i*math.pi/2, EnemyBullet.static.TYPE_LASER))
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

function Mine:getGems()
	return 3
end

return Mine

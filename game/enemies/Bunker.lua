local Enemy = require("game.Enemy")
local EnemyBullet = require("game.EnemyBullet")
local Flash = require("game.Flash")

local MAX_HEALTH = 3
local MOVE_SPEED = 50

local Bunker = class("game.enemies.Bunker", Enemy)

function Bunker:enter(properties)
	Enemy.enter(self, MAX_HEALTH)

	self.x = properties.x
	self.y = -30
	self.speed = properties.speed or MOVE_SPEED
	self.can_shoot = properties.shoot ~= false
	self.has_shot = false

	if properties.time then
		self.time = properties.time
	else
		self.time = (properties.y - self.y) / self.speed
	end

	self:setRenderer(prox.Animator("data/animators/enemies/bunker.lua"))
	self:getRenderer():setProperty("armed", self.can_shoot)
	self:setCollider(prox.BoxCollider(30, 30))
end

function Bunker:update(dt, rt)
	dt, rt = Enemy.update(self, dt, rt)

	self.y = self.y + self.speed * dt
	if self.y > prox.window.getHeight() + 30 then
		self:remove()
	end

	self.time = self.time - dt
	if self.can_shoot then
		if not self.has_shot then
			if self.time < 0.5 and self.time % 0.25 > 0.125 then
				self:getRenderer():setShader(self.white_shader)
			end
			if self.time <= 0 then
				self.has_shot = true
				self:getRenderer():setProperty("armed", false)
				self:shoot()
			end
		end
	end
end

function Bunker:shoot()
	self:getScene():add(EnemyBullet(self.x, self.y, math.pi/2))
	self:getScene():add(Flash(self.x, self.y))
end

function Bunker:getGems()
	return 1
end

return Bunker

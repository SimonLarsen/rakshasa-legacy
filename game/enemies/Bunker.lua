local Enemy = require("game.Enemy")
local EnemyBullet = require("game.EnemyBullet")
local Flash = require("game.Flash")

local MOVE_SPEED = 50

local Bunker = class("game.enemies.Bunker", Enemy)

function Bunker:enter(properties)
	Enemy.enter(self)

	self.x = properties.x
	self.y = -30
	self.speed = properties.speed or MOVE_SPEED
	self.can_shoot = properties.shoot ~= false
	self.has_shot = false
	self.charged = false

	if properties.time then
		self.time = properties.time
	else
		self.time = (properties.y - self.y) / self.speed
	end

	self.base_renderer = prox.Animator("data/animators/enemies/bunker.lua")
	self.base_renderer:setProperty("armed", self.can_shoot)
	self:setRenderer(prox.MultiRenderer())
	self:getRenderer():addRenderer(self.base_renderer)

	if self.can_shoot then
		self:getRenderer():addRenderer(prox.Animation("data/animations/bullets/enemy_ball.lua"), 1, 1)
	end

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
		if not self.charged and self.time <= 0.06*15 then
			self.charged = true
			self:getRenderer():addRenderer(prox.Animation("data/animations/enemies/bunker_charge.lua"))
		end
		if not self.has_shot and self.time <= 0 then
			self.has_shot = true
			self.base_renderer:setProperty("armed", false)
			self:shoot()
			self:getRenderer():removeRenderer(3)
			self:getRenderer():removeRenderer(2)
		end
	end
end

function Bunker:shoot()
	self:getScene():add(EnemyBullet(self.x, self.y, math.pi/2))
	self:getScene():add(Flash(self.x, self.y))
end

return Bunker

local Enemy = require("game.Enemy")
local EnemyBullet = require("game.EnemyBullet")
local Flash = require("game.Flash")

local Turret = class("game.enemies.Turret", Enemy)

local MAX_HEALTH = 12
local MOVE_SPEED = 40
local SALVO_COOLDOWN = 2.0
local BULLET_COOLDOWN = 0.18
local SALVO_SIZE = 4

function Turret:enter(properties)
	Enemy.enter(self, MAX_HEALTH)

	self.x = properties.x
	self.y = -30
	self.speed = properties.speed or MOVE_SPEED
	self.salvo_cooldown = properties.salvo_cooldown or 2.5
	self.next_salvo_cooldown = self.salvo_cooldown
	self.bullet_cooldown = properties.bullet_cooldown or BULLET_COOLDOWN
	self.next_bullet_cooldown = self.bullet_cooldown
	self.salvo = 0
	self.shoot_dir = 0
	self.salvo_size = properties.salvo_size or SALVO_SIZE

	self.player_chain = self:getScene():find("chain")

	self:setRenderer(prox.Animation("data/animations/enemies/turret.lua"))
	self:setCollider(prox.BoxCollider(30, 30))
end

function Turret:update(dt, rt)
	dt, rt = Enemy.update(self, dt, rt)

	self.y = self.y + self.speed * dt
	if self.y > prox.window.getHeight()+30 then
		self:remove()
	end

	self.next_salvo_cooldown = self.next_salvo_cooldown - dt
	if self.next_salvo_cooldown <= 0 then
		self.next_salvo_cooldown = self.salvo_cooldown
		self.salvo = self.salvo_size
		local xdist = self.player_chain.x - self.x
		local ydist = self.player_chain.y - self.y
		self.shoot_dir = math.atan2(ydist, xdist)
	end

	self.next_bullet_cooldown = self.next_bullet_cooldown - dt
	if self.salvo > 0 and self.next_bullet_cooldown <= 0 then
		self.salvo = self.salvo-1
		self.next_bullet_cooldown = self.bullet_cooldown
		self:shoot()
	end
end

function Turret:shoot()
	self:getScene():add(EnemyBullet(self.x, self.y, self.shoot_dir, EnemyBullet.static.TYPE_LASER))
	self:getScene():add(Flash(self.x, self.y))
end

function Turret:getGems()
	return 2
end

return Turret

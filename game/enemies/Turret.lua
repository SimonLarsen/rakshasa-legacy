local Enemy = require("game.Enemy")
local EnemyBullet = require("game.EnemyBullet")

local Turret = class("game.Turret", Enemy)

local MAX_HEALTH = 12
local MOVE_SPEED = 40
local SALVE_COOLDOWN = 2.0
local BULLET_COOLDOWN = 0.18
local SALVE = 4

function Turret:enter(properties)
	Enemy.enter(self, MAX_HEALTH)

	self.x = properties.x
	self.y = -30
	self.salve_cooldown = 2.5
	self.bullet_cooldown = 0
	self.salve = 0
	self.shoot_dir = 0

	self.player_chain = self:getScene():find("chain")

	self:setRenderer(prox.Sprite("data/images/enemies/turret.png", 19, 19))
	self:setCollider(prox.BoxCollider(30, 30))
end

function Turret:update(dt, rt)
	dt, rt = Enemy.update(self, dt, rt)

	self.y = self.y + MOVE_SPEED * dt
	if self.y > prox.window.getHeight()+30 then
		self:remove()
	end

	self.salve_cooldown = self.salve_cooldown - dt
	if self.salve_cooldown <= 0 then
		self.salve_cooldown = SALVE_COOLDOWN
		self.salve = SALVE
		local xdist = self.player_chain.x - self.x
		local ydist = self.player_chain.y - self.y
		self.shoot_dir = math.atan2(ydist, xdist)
	end

	self.bullet_cooldown = self.bullet_cooldown - dt
	if self.salve > 0 and self.bullet_cooldown <= 0 then
		self.salve = self.salve-1
		self.bullet_cooldown = BULLET_COOLDOWN
		self:shoot()
	end
end

function Turret:shoot()
	self:getScene():add(EnemyBullet(self.x, self.y, self.shoot_dir, EnemyBullet.static.TYPE_LASER))
end

function Turret:getGems()
	return 2
end

return Turret

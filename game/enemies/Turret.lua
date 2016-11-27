local Enemy = require("game.Enemy")
local EnemyBullet = require("game.EnemyBullet")

local Turret = class("game.Turret", Enemy)

local MAX_HEALTH = 15
local MOVE_SPEED = 15
local BULLET_COOLDOWN = 2.0

function Turret:enter(properties)
	Enemy.enter(self, MAX_HEALTH)

	self.x = properties.x
	self.y = -30
	self.cooldown = 2.5

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

	self.cooldown = self.cooldown - dt
	if self.y > 16 and self.cooldown <= 0 then
		self.cooldown = BULLET_COOLDOWN
		self:shoot()
	end
end

function Turret:shoot()
	local xdist = self.player_chain.x - self.x
	local ydist = self.player_chain.y - self.y
	local dir = math.atan2(ydist, xdist)
	self:getScene():add(EnemyBullet(self.x, self.y, dir, EnemyBullet.static.TYPE_BALL))
end

function Turret:getGems()
	return 2
end

return Turret

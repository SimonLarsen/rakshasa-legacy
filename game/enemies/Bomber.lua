local Enemy = require("game.Enemy")
local EnemyBullet = require("game.EnemyBullet")
local Slowable = require("game.Slowable")
local EnemyBulletBomb = require("game.EnemyBulletBomb")
local Flash = require("game.Flash")

local Bomber = class("game.enemies.Bomber", Enemy)

local MAX_HEALTH = 30
local ENTER_TIME = 2.0
local COOLDOWN = 6.0

function Bomber:enter(properties)
	Enemy.enter(self, MAX_HEALTH)
	self.destx = properties.points[1].x
	self.desty = properties.points[1].y

	self.x = self.destx
	self.y = -44
	self.entered = false
	self.entered_time = 0
	self.cooldown = 0

	self.bomb_desty = properties.points[2].y

	self:setRenderer(prox.Animation("data/animations/enemies/bomber.lua"))
	self:setCollider(prox.BoxCollider(66, 38))

	self.pattern = {
		shot_count = 4,
		shot_rotation_offset = math.pi/2
	}

	self.timer = prox.timer.tween(ENTER_TIME, self, {y = self.desty}, "out-quad", function() self.entered = true end)
end

function Bomber:update(dt, rt)
	dt, rt = Enemy.update(self, dt, rt)

	if not self.entered then return end
	self.entered_time = self.entered_time + dt

	self.y = self.desty + math.sin(self.entered_time)*4
	self.x = self.destx + math.sin(self.entered_time*1.2)*8

	self.cooldown = self.cooldown - dt
	if self.cooldown <= 0 then
		self:shoot()
		self.cooldown = COOLDOWN
	end
end

function Bomber:shoot()
	self:getScene():add(EnemyBulletBomb(self.x, self.y+8, self.x, self.bomb_desty, 1.2, 3, self.pattern))
	self:getScene():add(Flash(self.x, self.y+8))
end

function Bomber:getGems()
	return 12
end

return Bomber

local Enemy = require("game.Enemy")
local EnemyBullet = require("game.EnemyBullet")
local Slowable = require("game.Slowable")
local EnemyBulletBomb = require("game.EnemyBulletBomb")

local Bomber = class("game.enemies.Bomber", Enemy)

local MAX_HEALTH = 20
local ENTER_TIME = 2.5
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

	self:setRenderer(prox.Sprite("data/images/enemies/fortress.png"))
	self:setCollider(prox.BoxCollider(58, 58))

	self.pattern = {
		shot_count = 4,
		shot_rotation_offset = math.pi/2,
		bullet_type = EnemyBullet.static.TYPE_BALL
	}

	self.timer = prox.timer.tween(ENTER_TIME, self, {y = self.desty}, "out-quad", function() self.entered = true end)
end

function Bomber:update(dt, rt)
	dt, rt = Enemy.update(self, dt, rt)

	if not self.entered then return end
	self.entered_time = self.entered_time + dt

	self.y = self.desty + math.sin(self.entered_time)*4

	self.cooldown = self.cooldown - dt
	if self.cooldown <= 0 then
		self:shoot()
		self.cooldown = COOLDOWN
	end
end

function Bomber:shoot()
	self:getScene():add(EnemyBulletBomb(self.x, self.y, self.x, self.bomb_desty, 1, 3, self.pattern))
end

function Bomber:getGems()
	return 12
end

return Bomber

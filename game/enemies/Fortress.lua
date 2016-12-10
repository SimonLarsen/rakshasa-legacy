local Enemy = require("game.Enemy")
local EnemyBullet = require("game.EnemyBullet")

local Fortress = class("game.enemies.Fortress", Enemy)

local MAX_HEALTH = 40
local ENTER_TIME = 2.5
local COOLDOWN = 3.0

function Fortress:enter(properties)
	Enemy.enter(self, MAX_HEALTH, true)

	self.destx = properties.x
	self.desty = properties.y
	self.x = self.destx
	self.y = -44
	self.entered = false
	self.cooldown = 0
	self.shoot_dir = 0

	self:setRenderer(prox.Sprite("data/images/enemies/fortress.png"))
	self:setCollider(prox.BoxCollider(58, 58))

	self.enter_timer = prox.timer.tween(ENTER_TIME, self, {y=self.desty}, "out-quad", function() self.entered = true end)
end

function Fortress:update(dt, rt)
	dt, rt = Enemy.update(self, dt, rt)

	if not self.entered then return end

	self.shoot_dir = self.shoot_dir + dt*1.5
	self.cooldown = self.cooldown - dt
	if self.cooldown <= 0 then
		self.cooldown = COOLDOWN
		prox.timer.every(0.1, function()
			for i=0, 3 do
				local bdir = i*math.pi/2 + self.shoot_dir
				self:getScene():add(EnemyBullet(self.x, self.y, bdir, EnemyBullet.static.TYPE_BALL))
			end
		end, 10)
	end
end

function Fortress:onRemove()
	prox.timer.cancel(self.enter_timer)
end

function Fortress:getGems()
	return 10
end

return Fortress

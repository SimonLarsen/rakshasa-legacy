local Enemy = require("game.Enemy")
local EnemyRainBullet = require("game.EnemyRainBullet")
local Flash = require("game.Flash")

local Dropship = class("game.enemies.Dropship", Enemy)

local MAX_HEALTH = 5

local ENTER_TIME = 2
local IDLE_TIME = 1
local EXIT_TIME = 1.5

Dropship.static.STATE_ENTER = 1
Dropship.static.STATE_IDLE  = 2
Dropship.static.STATE_EXIT  = 3

function Dropship:enter(properties)
	Enemy.enter(self, MAX_HEALTH)

	assert(#properties.points == 3, "Dropship needs three point coordinates.")
	self.points = properties.points
	self.x = self.points[1].x
	self.y = self.points[1].y
	self.time = 0

	self.state = Dropship.static.STATE_ENTER

	self:setRenderer(prox.Animation("data/animations/enemies/dropship.lua"))
	self:setCollider(prox.BoxCollider(40, 32))

	self.timer = prox.timer.tween(ENTER_TIME, self, {x = self.points[2].x, y = self.points[2].y}, "out-quad",
		function()
			self.state = Dropship.static.STATE_IDLE
			self:shoot()
		end
	)
end

function Dropship:update(dt, rt)
	if self.state == Dropship.static.STATE_IDLE then
		self.time = self.time + dt
		if self.time >= IDLE_TIME then
			self.state = Dropship.static.STATE_EXIT
			self.timer = prox.timer.tween(EXIT_TIME, self, {x = self.points[3].x, y = self.points[3].y}, "in-quad",
				function()
					self:remove()
				end
			)
		end
	end
end

function Dropship:shoot()
	self:getScene():add(EnemyRainBullet(self.x, self.y-6, -70, -130))
	self:getScene():add(EnemyRainBullet(self.x, self.y-6,   0, -130))
	self:getScene():add(EnemyRainBullet(self.x, self.y-6,  70, -130))
	self:getScene():add(Flash(self.x, self.y-6))
end

function Dropship:getGems()
	return 2
end

function Dropship:onRemove()
	Enemy.onRemove(self)

	if self.timer then
		prox.timer.cancel(self.timer)
	end
end

return Dropship

local Enemy = require("game.Enemy")
local Bullet = require("game.Bullet")

local EnemyShip = class("game.EnemyShip", Enemy)

EnemyShip.static.STATE_ENTER = 1
EnemyShip.static.STATE_IDLE  = 2
EnemyShip.static.STATE_EXIT  = 3

local MAX_HEALTH = 2

local ENTER_TIME = 1
local IDLE_TIME = 2

local IDLE_SPEED = 10
local IDLE_ACCELERATION = 50

local EXIT_SPEED = 150
local EXIT_ACCELERATION = 150

local BULLET_COOLDOWN = 2.5

function EnemyShip:enter(destx, desty)
	self:setName("enemy_ship")
	self.x = destx
	self.y = -20
	self.destx = destx
	self.desty = desty
	self.state = EnemyShip.static.STATE_ENTER
	self.time = 0
	self.yspeed = 0
	self.health = MAX_HEALTH
	self.cooldown = ENTER_TIME

	self.player_chain = self:getScene():find("chain")

	self.timer = prox.timer.tween(
		ENTER_TIME, self,
		{x = self.destx, y = self.desty}, "out-quad",
		function()
			self.state = EnemyShip.static.STATE_IDLE
			self.time = IDLE_TIME
		end
	)

	self:setRenderer(prox.Sprite("data/images/enemy_ship.png"))
	self:setCollider(prox.BoxCollider(32, 24))
end

function EnemyShip:update(dt, rt)
	if self.state == EnemyShip.static.STATE_IDLE then
		self.time = self.time - dt
		self.yspeed = prox.math.cap(self.yspeed + IDLE_ACCELERATION * dt, 0, IDLE_SPEED)
		self.y = self.y + self.yspeed * dt
		if self.time <= 0 then
			self.state = EnemyShip.static.STATE_EXIT
		end

	elseif self.state == EnemyShip.static.STATE_EXIT then
		self.yspeed = prox.math.cap(self.yspeed + EXIT_ACCELERATION * dt, 0, EXIT_SPEED)
		self.y = self.y + self.yspeed * dt
	end

	self.cooldown = self.cooldown - dt
	if self.cooldown <= 0 then
		self.cooldown = BULLET_COOLDOWN
		self:shoot()
	end

	if self.y > prox.window.getHeight()+32 then
		self:kill()
	end
end

function EnemyShip:shoot()
	local xdist = self.player_chain.x - self.x
	local ydist = self.player_chain.y - self.y
	local dir = math.atan2(ydist, xdist)
	self:getScene():add(Bullet(self.x, self.y+14, dir, Bullet.static.TYPE_ENEMY_BULLET))
end

function EnemyShip:onCollide(o, dt, rt)
	if o:getName() == "bullet" and o:isPlayerBullet() then
		self.health = self.health - o:getDamage()
		if self.health <= 0 then
			self:kill()
		end
		o:kill()
	end
end

function EnemyShip:kill()
	prox.timer.cancel(self.timer)
	self:remove()
end

return EnemyShip

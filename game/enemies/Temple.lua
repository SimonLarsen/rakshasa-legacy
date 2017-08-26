local Enemy = require("game.Enemy")
local EnemyChargeBullet = require("game.EnemyChargeBullet")
local Flash = require("game.Flash")

local Temple = class("game.enemies.Temple", Enemy)

local MAX_HEALTH = 40

local MOVE_SPEED = 25
local ENTER_SALVO_COOLDOWN = 2.5
local SALVO_COOLDOWN = 2.5
local ENTER_TIME = 1.5

function Temple:enter(properties)
	Enemy.enter(self, MAX_HEALTH, true)

	self.destx = properties.x
	self.desty = properties.y
	self.x = self.destx
	self.y = -30
	self.cooldown = properties.enter_salvo_cooldown or ENTER_SALVO_COOLDOWN
	self.entered = false
	self.entered_time = 0
	self.salvo_cooldown = properties.salvo_cooldown or SALVO_COOLDOWN

	self.player_chain = self:getScene():find("chain")

	self:setRenderer(prox.Animation("data/animations/enemies/temple.lua"))
	self:setCollider(prox.BoxCollider(80, 32))

	self.enter_timer = prox.timer.tween(properties.enter_time or ENTER_TIME, self, {y=self.desty}, "out-quad", function() self.entered = true end)
end

function Temple:update(dt, rt)
	dt, rt = Enemy.update(self, dt, rt)

	self.cooldown = self.cooldown - dt
	if self.cooldown <= 0 then
		self.cooldown = self.salvo_cooldown
		self:shoot()
	end

	if not self.entered then return end
	self.entered_time = self.entered_time + dt

	self.x = self.destx + math.sin(self.entered_time)*8
	self.y = self.desty + math.sin(self.entered_time*1.1)*6
end

function Temple:shoot()
	local xdist = self.player_chain.x - self.x
	local ydist = self.player_chain.y - self.y
	
	local dir = math.atan2(ydist, xdist)

	for i=-3,3 do
		local outdir = 1.5*math.pi + i*0.4
		local offx = math.cos(outdir) * 40
		local offy = math.sin(outdir) * 40

		local sdir = dir + i*0.075
		self:getScene():add(EnemyChargeBullet(self.x, self.y, self.x+offx, self.y+offy, sdir, 1.0))
	end
end

function Temple:getGems()
	return 5
end

function Temple:onRemove()
	prox.timer.cancel(self.enter_timer)
end

return Temple

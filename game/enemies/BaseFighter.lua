local Enemy = require("game.Enemy")

local BaseFighter = class("game.enemies.BaseFighter", Enemy)

BaseFighter.static.STATE_ENTER = 1
BaseFighter.static.STATE_IDLE  = 2
BaseFighter.static.STATE_EXIT  = 3

local BULLET_COOLDOWN = 2.5

local SPEED = {
	[BaseFighter.static.STATE_ENTER] = 275,
	[BaseFighter.static.STATE_IDLE]  = 30,
	[BaseFighter.static.STATE_EXIT]  = 200
}

local ACCELERATION = {
	[BaseFighter.static.STATE_ENTER] = 150,
	[BaseFighter.static.STATE_IDLE]  = 350,
	[BaseFighter.static.STATE_EXIT]  = 200
}

function BaseFighter:enter(properties, MAX_HEALTH)
	Enemy.enter(self, MAX_HEALTH)

	assert(#properties.points == 4, "BaseFighter needs four point coordinates")
	self.points = properties.points
	self.x = self.points[1].x
	self.y = self.points[1].y

	self.state = BaseFighter.static.STATE_ENTER
	self.time = 0
	self.speed = 100
	self.cooldown = 0.5

	self.player_chain = self:getScene():find("chain")

	self:setRenderer(self:getAnimation())
	self:setCollider(self:getCollider())
end

function BaseFighter:update(dt, rt)
	dt, rt = Enemy.update(self, dt, rt)

	--local destx = self.points[self.state+1].x
	local destx = self.x
	local desty = self.points[self.state+1].y

	self.speed = prox.math.movetowards(self.speed, SPEED[self.state], ACCELERATION[self.state]*dt)
	self.x, self.y = prox.math.movetowards2(self.x, self.y, destx, desty, self.speed*dt)
	local dist = math.sqrt((self.x - destx)^2 + (self.y - desty)^2)

	if dist < 0.5 then
		if self.state == BaseFighter.static.STATE_EXIT then
			self:remove()
		else
			self.state = self.state + 1
		end
	end

	if self.state ~= BaseFighter.static.STATE_ENTER then
		self.cooldown = self.cooldown - dt
		if self.cooldown <= 0 then
			self.cooldown = BULLET_COOLDOWN
			self:shoot()
		end
	end
end

function BaseFighter:getGems()
	return 2
end

return BaseFighter

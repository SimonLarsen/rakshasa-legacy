local Enemy = require("game.Enemy")

local BaseDrone = class("game.enemies.BaseDrone", Enemy)

local MOVE_SPEED = 180
local BULLET_COOLDOWN = 2.5
local START_COOLDOWN = 1.1

function BaseDrone:enter(properties, max_health, speed)
	Enemy.enter(self, max_health)

	assert(#properties.points >= 2, "BaseDrone needs at least two points.")
	self.points = properties.points
	self.speed = speed or MOVE_SPEED
	self.x = self.points[1].x
	self.y = self.points[1].y
	self.target = 2

	self.cooldown = properties.start_cooldown or 1.1
	self.player_chain = self:getScene():find("chain")

	self:setRenderer(self:getAnimation())
	self:setCollider(self:getCollider())
end

function BaseDrone:update(dt, rt)
	dt, rt = Enemy.update(self, dt, rt)

	local destx, desty = self.points[self.target].x, self.points[self.target].y
	self.x, self.y = prox.math.movetowards2(self.x, self.y, destx, desty, self.speed*dt)
	local dist = math.sqrt((self.x - destx)^2 + (self.y - desty)^2)

	if dist < 0.5 then
		if self.target == #self.points then
			self:remove()
		else
			self.target = self.target + 1
		end
	end

	-- shooting disabled
	self.cooldown = self.cooldown - dt
	if self.cooldown <= 0
	and self.x > 16 and self.x < settings.screen_width-16
	and self.y > 16 and self.y < settings.screen_height-16 then
		self.cooldown = BULLET_COOLDOWN
		self:shoot()
	end

	local rot = self:getRenderer():getRotation()
	self:getRenderer():setRotation(rot - 2*dt)
end

function BaseDrone:onRemove()
	if self.timer then
		prox.timer.cancel(self.timer)
	end
end

return BaseDrone

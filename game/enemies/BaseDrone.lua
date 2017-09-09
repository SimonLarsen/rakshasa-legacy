local Enemy = require("game.Enemy")

local BaseDrone = class("game.enemies.BaseDrone", Enemy)

local MOVE_SPEED = 180
local ENTER_COOLDOWN = 1.1
local COOLDOWN = 2.5

function BaseDrone:enter(properties, max_health, speed)
	Enemy.enter(self, max_health)

	assert(#properties.points >= 2, "BaseDrone needs at least two points.")
	self.points = properties.points
	self.speed = speed or MOVE_SPEED
	self.x = self.points[1].x
	self.y = self.points[1].y
	self.target = 2

	self.next_shot = properties.enter_cooldown or ENTER_COOLDOWN
	self.cooldown = properties.cooldown or COOLDOWN
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
	self.next_shot = self.next_shot - dt
	if self.next_shot <= 0
	and self.x > 16 and self.x < settings.screen_width-16
	and self.y > 16 and self.y < settings.screen_height-16 then
		self.next_shot = self.cooldown
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

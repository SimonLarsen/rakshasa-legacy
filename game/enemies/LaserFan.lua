local EnemyBullet = require("game.EnemyBullet")

local LaserFan = class("game.enemies.LaserFan", EnemyBullet)

local MOVE_SPEED = 60
local ROTATION_SPEED = 1

function LaserFan:enter(properties)
	assert(#properties.points == 2, "LaserFan needs two points.")

	local p1, p2 = properties.points[1], properties.points[2]
	if p1.x > p2.x then
		p1, p2 = p2, p1
	end

	local xdist = p2.x - p1.x
	local ydist = p1.y - p2.y
	self.dist = math.sqrt(xdist^2 + ydist^2)

	self.x = math.floor((p1.x + p2.x) / 2 + 0.5)
	self.y = math.floor((p1.y + p2.y) / 2 + 0.5)
	self.dir = math.atan2(xdist, -ydist)
	self.speed = MOVE_SPEED or properties.speed
	self.rotation_speed = ROTATION_SPEED or properties.rotation_speed

	self.hc_rect = HC.rectangle(0, 0, self.dist, 16)
	self.hc_rect:setRotation(self.dir)

	self.beam_anim = prox.Animation("data/animations/enemies/laser_beam_orthogonal.lua")
	self.beam_anim:setScale(self.dist, 1)

	self.turret_anim = prox.Animator("data/animators/enemies/laser_switch_turret.lua")
	self.turret_anim:setProperty("state", false)

	self:setRenderer(prox.MultiRenderer())
	self:getRenderer():addRenderer(self.beam_anim)
	self:getRenderer():addRenderer(self.turret_anim)
end

function LaserFan:update(dt, rt)
	self.y = self.y + self.speed * dt
	self.dir = self.dir + self.rotation_speed * dt

	self.hc_rect:moveTo(self.x, self.y)
	self.hc_rect:setRotation(self.dir)
	self.beam_anim:setRotation(self.dir)

	if self.y > prox.window.getHeight() + self.dist / 2 + 16 then
		self:remove()
	end
end

function LaserFan:getHCShape()
	return self.hc_rect
end

function LaserFan:kill()
	
end

return LaserFan

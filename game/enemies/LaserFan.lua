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
	self.dir = math.atan2(ydist, xdist)
	self.speed = MOVE_SPEED or properties.speed
	self.rotation_speed = ROTATION_SPEED or properties.rotation_speed

	self.hc_rect = HC.rectangle(0, 0, self.dist, 16)
	self.hc_rect:setRotation(self.dir)

	self.turret_anim = prox.Animation("data/animations/enemies/laser_fan.lua")

	self.beamw = (self.dist - 39) / 2
	self.beam_anim1 = prox.Animation("data/animations/enemies/laser_beam_orthogonal.lua")
	self.beam_anim1:setScale(self.beamw, 1)
	self.beam_anim2 = prox.Animation("data/animations/enemies/laser_beam_orthogonal.lua")
	self.beam_anim2:setScale(self.beamw, 1)

	self.beam_tip1 = prox.Animation("data/animations/enemies/laser_tip.lua")
	self.beam_tip2 = prox.Animation("data/animations/enemies/laser_tip.lua")

	self:setRenderer(prox.MultiRenderer())
	self:getRenderer():addRenderer(self.beam_anim1)
	self:getRenderer():addRenderer(self.beam_anim2)
	self:getRenderer():addRenderer(self.beam_tip1)
	self:getRenderer():addRenderer(self.beam_tip2)
	self:getRenderer():addRenderer(self.turret_anim)
end

function LaserFan:update(dt, rt)
	self.y = self.y + self.speed * dt
	self.dir = self.dir + self.rotation_speed * dt

	self.hc_rect:moveTo(self.x, self.y)
	self.hc_rect:setRotation(self.dir)
	self.turret_anim:setRotation(self.dir+math.pi/2)

	self.beam_anim1:setRotation(self.dir)
	self.beam_anim2:setRotation(self.dir)
	self.beam_tip1:setRotation(self.dir+math.pi)
	self.beam_tip2:setRotation(self.dir)

	local ox = math.cos(self.dir) * (18 + self.beamw / 2)
	local oy = math.sin(self.dir) * (18 + self.beamw / 2)
	self:getRenderer():setOffset(1, -ox, -oy)
	self:getRenderer():setOffset(2, ox, oy)
	ox = math.cos(self.dir) * (17 + self.beamw)
	oy = math.sin(self.dir) * (17 + self.beamw)
	self:getRenderer():setOffset(3, -ox, -oy)
	self:getRenderer():setOffset(4, ox, oy)

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

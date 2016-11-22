local EnemyBullet = require("game.EnemyBullet")

local Laser = class("game.Laser", EnemyBullet)

local MAX_HEALTH = 1
local MOVE_SPEED = 30

function Laser:enter(properties)
	assert(#properties.points == 2, "Laser needs two points.")

	local p1, p2 = properties.points[1], properties.points[2]
	self.x = (p1.x + p2.x) / 2
	self.y = -math.abs(p1.y-p2.y)-8
	self.dir = math.atan2(p2.y-p1.y, p2.x-p1.x)
	self.dist = math.sqrt((p1.x-p2.x)^2 + (p1.y-p2.y)^2)
	self.speed = properties.speed or MOVE_SPEED

	local beam_anim = prox.Animation("data/animations/enemies/laser_beam.lua")
	local turret_anim1 = prox.Animation("data/animations/enemies/laser_turret.lua")
	local turret_anim2 = prox.Animation("data/animations/enemies/laser_turret.lua")

	local odist = self.dist+12
	self.y = -math.abs(math.sin(self.dir)*odist/2) - 30

	beam_anim.sx = self.dist
	beam_anim.r = self.dir
	turret_anim1.r = self.dir
	turret_anim2.r = self.dir
	turret_anim2.sx = -1

	self:setRenderer(prox.MultiRenderer())
	self:getRenderer():addRenderer(beam_anim, 0, 0)
	self:getRenderer():addRenderer(turret_anim1, -math.cos(self.dir)*odist/2, -math.sin(self.dir)*odist/2)
	self:getRenderer():addRenderer(turret_anim2, math.cos(self.dir)*odist/2, math.sin(self.dir)*odist/2)

	self.hc_rect = HC.rectangle(0, 0, odist, 16)
	self.hc_rect:setRotation(self.dir)
end

function Laser:update(dt, rt)
	self.y = self.y + self.speed * dt
	self.hc_rect:moveTo(self.x, self.y)

	if self.y > prox.window.getHeight()+math.sin(self.dir)*self.dist+32 then
		self:remove()
	end
end

function Laser:getHCShape()
	return self.hc_rect
end

function Laser:kill()
	
end

return Laser

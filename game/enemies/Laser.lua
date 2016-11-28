local EnemyBullet = require("game.EnemyBullet")

local Laser = class("game.Laser", EnemyBullet)

local MAX_HEALTH = 1
local MOVE_SPEED = 50

function Laser:enter(properties)
	assert(#properties.points == 2, "Laser needs two points.")

	local p1, p2 = properties.points[1], properties.points[2]
	if p1.x > p2.x then
		p1, p2 = p2, p1
	end
	local xdist = p2.x - p1.x
	local ydist = p2.y - p1.y

	self.x = math.floor((p1.x + p2.x) / 2)
	self.y = -math.abs(ydist)-8
	self.dir = math.floor(math.atan2(ydist, xdist) / (math.pi/4) + 0.5) * (math.pi/4)
	self.dist = math.sqrt(xdist^2 + ydist^2)
	self.speed = properties.speed or MOVE_SPEED

	local ortho = math.floor(self.dir / (math.pi/4) + 0.5) % 2 == 0
	local odist = self.dist+12

	self:setRenderer(prox.MultiRenderer())

	local turret_anim1, turret_anim2

	if ortho then
		local beam_anim = prox.Animation("data/animations/enemies/laser_beam_orthogonal.lua")
		self:getRenderer():addRenderer(beam_anim, 0, 0)
		beam_anim.sx = self.dist
		beam_anim.r = self.dir

		turret_anim1 = prox.Animation("data/animations/enemies/laser_turret_orthogonal.lua")
		turret_anim2 = prox.Animation("data/animations/enemies/laser_turret_orthogonal.lua")
		turret_anim1.r = self.dir
		turret_anim2.r = self.dir
		turret_anim2.sx = -1

		self:getRenderer():addRenderer(turret_anim1, math.floor(-math.cos(self.dir)*odist/2), math.floor(-math.sin(self.dir)*odist/2))
		self:getRenderer():addRenderer(turret_anim2, math.floor( math.cos(self.dir)*odist/2), math.floor( math.sin(self.dir)*odist/2))
	else
		local beams = math.ceil(xdist / 7)
		local sgnx = prox.math.sign(xdist)
		local sgny = prox.math.sign(ydist)

		local ox = -sgnx*math.floor(beams*7 / 2+4)
		local oy = -sgny*math.floor(beams*7 / 2+4)

		for i=1, beams do
			local spr = prox.Animation("data/animations/enemies/laser_part_diagonal.lua")
			spr.r = self.dir - math.pi/4

			if self.dir < 0 then
				self:getRenderer():addRenderer(spr, ox+i*7*sgnx-1, oy+i*7*sgny)
			else
				self:getRenderer():addRenderer(spr, ox+i*7*sgnx, oy+i*7*sgny)
			end
		end

		turret_anim1 = prox.Animation("data/animations/enemies/laser_turret_diagonal.lua")
		turret_anim2 = prox.Animation("data/animations/enemies/laser_turret_diagonal.lua")
		turret_anim1.r = self.dir - math.pi/4
		turret_anim2.r = self.dir - math.pi/4 + math.pi
	end

	self:getRenderer():addRenderer(turret_anim1, math.floor(-math.cos(self.dir)*odist/2), math.floor(-math.sin(self.dir)*odist/2))
	self:getRenderer():addRenderer(turret_anim2, math.floor( math.cos(self.dir)*odist/2), math.floor( math.sin(self.dir)*odist/2))

	self.hc_rect = HC.rectangle(0, 0, odist, 16)
	self.hc_rect:setRotation(self.dir)
end

function Laser:update(dt, rt)
	self.y = self.y + self.speed * dt
	self.hc_rect:moveTo(self.x, self.y)

	if self.y > settings.screen_height+math.abs(math.sin(self.dir))*(self.dist+12)+32 then
		self:remove()
	end
end

function Laser:getHCShape()
	return self.hc_rect
end

function Laser:kill()
	
end

return Laser

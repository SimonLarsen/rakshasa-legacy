local EnemyBullet = require("game.EnemyBullet")
local LaserSwitchTurret = require("game.enemies.LaserSwitchTurret")

local LaserSwitch = class("game.enemies.LaserSwitch", EnemyBullet)

local MOVE_SPEED = 40

function LaserSwitch:enter(properties)
	assert(#properties.points == 2, "Laser needs two points.")

	local p1, p2 = properties.points[1], properties.points[2]
	if p1.x > p2.x then
		p1, p2 = p2, p1
	end
	local xdist = p2.x - p1.x - 34

	self.x = math.floor((p1.x + p2.x) / 2 + 0.5)
	self.y = -20
	self.z = 1
	self.speed = properties.speed or MOVE_SPEED
	self.on = true
	self.time = 0
	self.anim_reset = false

	self.turret_left = self:getScene():add(LaserSwitchTurret(p1.x+3, self.y, 1, self.speed))
	self.turret_right = self:getScene():add(LaserSwitchTurret(p2.x-3, self.y, -1, self.speed))

	local beam_anim = prox.Animation("data/animations/enemies/laser_beam_orthogonal.lua")
	self:setRenderer(beam_anim)
	beam_anim:setScale(xdist, 1)
	
	self.hc_rect = HC.rectangle(0, 0, xdist+68, 16)
end

function LaserSwitch:update(dt, rt)
	self.y = self.y + self.speed * dt
	self.hc_rect:moveTo(self.x, self.y)

	if not self.anim_reset and self.turret_left:isDestroyed() ~= self.turret_right:isDestroyed() then
		self:getRenderer():reset()
		local r1 = self.turret_left:getRenderer()
		local r2 = self.turret_right:getRenderer()
		r1._animations[r1._state]:reset()
		r2._animations[r2._state]:reset()
		self.anim_reset = true
	end
	if self.turret_left:isDestroyed() and self.turret_right:isDestroyed() then
		self:remove()
		self.turret_left:remove()
		self.turret_right:remove()
	end
end

function LaserSwitch:getHCShape()
	if self.on then
		return self.hc_rect
	end
end

function LaserSwitch:kill()
	
end

return LaserSwitch

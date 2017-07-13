local BulletPattern = require("game.bullets.BulletPattern")
local EnemyChargeBullet = require("game.EnemyChargeBullet")

local ChargeFanPattern = class("game.bullets.ChargeFanPattern", BulletPattern)

function ChargeFanPattern:initialize(parent, ox, oy, params)
	BulletPattern.initialize(self, parent, ox, oy)

	self.salvo_delay = params.salvo_delay or 2
	self.salvo_size = params.salvo_size or 1
	self.fan_rotation = params.fan_rotation or 3*math.pi/2
	self.fan_rotation_offset = params.fan_rotation_offset or 0
	self.fan_radius = params.fan_radius or 40
	self.warmup = params.warmup or 0
	self.charge_time = params.charge_time or 1

	self.player_chain = self.parent:getScene():find("chain")

	self:reset()
end

function ChargeFanPattern:reset()
	self.next_salvo = self.warmup
end

function ChargeFanPattern:update(dt)
	self.next_salvo = self.next_salvo - dt
	if self.next_salvo <= 0 then
		self.next_salvo = self.salvo_delay
		self:shoot()
	end
end

function ChargeFanPattern:shoot()
	local posx, posy = self:getPosition()

	local xdist = self.player_chain.x - posx
	local ydist = self.player_chain.y - posy

	local dir = math.atan2(ydist, xdist)

	local fan_dir = self.fan_rotation
	for i=1,self.salvo_size do
		local offx = math.cos(fan_dir) * self.fan_radius
		local offy = math.sin(fan_dir) * self.fan_radius
		self.parent:getScene():add(EnemyChargeBullet(posx, posy, posx+offx, posy+offy, dir, self.charge_time))
		fan_dir = fan_dir + self.fan_rotation_offset
	end
end

return ChargeFanPattern

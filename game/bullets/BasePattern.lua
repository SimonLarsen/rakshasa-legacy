local EnemyBullet = require("game.EnemyBullet")
local BulletPattern = require("game.bullets.BulletPattern")
local Flash = require("game.Flash")

local BasePattern = class("game.bullets.BasePattern", BulletPattern)

function BasePattern:initialize(parent, ox, oy, params)
	BulletPattern.initialize(self, parent, ox, oy)
	self.salvo_delay = params.salvo_delay or 0.1
	self.salvo_size = params.salvo_size or 1
	self.salvo_rotation_offset = params.salvo_rotation_offset or 0
	self.shot_delay = params.shot_delay or 0.1
	self.shot_count = params.shot_count or 1
	self.shot_rotation_offset = params.shot_rotation_offset or 0
	self.rotation_speed = params.rotation_speed or 0
	self.warmup = params.warmup or 0
	self.start_rotation = params.start_rotation or math.pi/2
	self.reset_rotation = params.reset_rotation or false
	self.target_player = params.target_player or false

	if self.target_player then
		self.player_chain = self.parent:getScene():find("chain")
	end

	self:reset()
end

function BasePattern:reset()
	self.rotation = self.start_rotation
	self.next_salvo = self.warmup
	self.next_shot = 0
	self.shots_fired = 0
end

function BasePattern:update(dt)
	self.rotation = self.rotation + self.rotation_speed*dt

	self.next_salvo = self.next_salvo - dt
	if self.next_salvo <= 0 then
		self.next_salvo = self.salvo_delay
		self.shots_fired = 0
		if self.reset_rotation then
			self.rotation = self.start_rotation
		end
	end

	self.next_shot = self.next_shot - dt
	if self.next_shot <= 0 and self.shots_fired < self.salvo_size then
		self.next_shot = self.shot_delay
		self.shots_fired = self.shots_fired + 1

		self:shoot(x, y)

		if self.shots_fired == self.salvo_size then
			self.rotation = self.rotation + self.salvo_rotation_offset
		end
	end
end

function BasePattern:shoot(x, y)
	local posx, posy = self:getPosition()

	local dir = self.rotation
	for i=1,self.shot_count do
		if self.target_player then
			local xdist = self.player_chain.x - posx
			local ydist = self.player_chain.y - posy
			dir = math.atan2(ydist, xdist)
		end
		local bullet = EnemyBullet(posx, posy, dir)
		self.parent:getScene():add(bullet)
		dir = dir + self.shot_rotation_offset
	end
	self.parent:getScene():add(Flash(posx, posy))
end

return BasePattern

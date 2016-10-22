local Enemy = require("game.Enemy")
local Drone = require("game.enemies.Drone")

local DroneSpawner = class("game.enemies.DroneSpawner", Enemy)

function DroneSpawner:enter(count, delay, points)
	Enemy.enter(self, 0)

	self.count = count
	self.delay = delay or 0.5
	self.points = points

	self.spawned = 0
	self.time = 0
end

function DroneSpawner:update(dt, rt)
	self.time = self.time - dt
	if self.time <= 0 then
		self.time = self.delay
		self.spawned = self.spawned + 1
		self:getScene():add(Drone(self.points))
	end

	if self.spawned == self.count then
		self:remove()
	end
end

function DroneSpawner:getGems()
	return 0
end

return DroneSpawner

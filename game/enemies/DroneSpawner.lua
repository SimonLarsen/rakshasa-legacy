local Enemy = require("game.Enemy")
local Drone = require("game.enemies.Drone")

local DroneSpawner = class("game.enemies.DroneSpawner", Enemy)

function DroneSpawner:enter(properties)
	Enemy.enter(self, 0)

	self.count = properties.count
	self.delay = properties.delay or 0.5
	self.points = properties.points

	self.spawned = 0
	self.time = 0
end

function DroneSpawner:update(dt, rt)
	self.time = self.time - dt
	if self.time <= 0 then
		self.time = self.delay
		self.spawned = self.spawned + 1
		self:getScene():add(Drone({points = self.points}))
	end

	if self.spawned == self.count then
		self:remove()
	end
end

function DroneSpawner:getGems()
	return 0
end

return DroneSpawner

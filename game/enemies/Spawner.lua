local Enemy = require("game.Enemy")

local Spawner = class("game.enemies.Spawner", Enemy)

function Spawner:enter(properties)
	Enemy.enter(self, 0)

	self.count = properties.count
	self.delay = properties.delay or 0.15
	self.points = properties.points
	self.properties = properties
	self.const = require("game.enemies." .. properties.type)

	self.spawned = 0
	self.time = 0
end

function Spawner:update(dt, rt)
	self.time = self.time - dt
	if self.time <= 0 then
		self.time = self.delay
		self.spawned = self.spawned + 1
		self:getScene():add(self.const(self.properties))
	end

	if self.spawned == self.count then
		self:remove()
	end
end

function Spawner:getGems()
	return 0
end

return Spawner

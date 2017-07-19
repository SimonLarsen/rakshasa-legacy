local PatternManager = class("game.bullets.PatternManager")

function PatternManager:initialize()
	self.patterns = {}
	self.delays = {}

	self:reset()
end

function PatternManager:add(pattern, delay)
	table.insert(self.patterns, pattern)
	table.insert(self.delays, delay)
end

function PatternManager:reset()
	self.index = 1
	self.time = 0
end

function PatternManager:setPattern(index)
	assert(self.index >= 1 and self.index <= #self.patterns)
	self.time = 0
	self.index = index
end

function PatternManager:update(dt)
	self.time = self.time + dt
	if self.time >= self.delays[self.index] then
		self.time = 0
		self.index = self.index % #self.patterns + 1
		self.patterns[self.index]:reset()
	end

	self.patterns[self.index]:update(dt)
end

return PatternManager

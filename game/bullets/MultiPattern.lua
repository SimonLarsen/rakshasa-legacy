local BulletPattern = require("game.bullets.BulletPattern")

local MultiPattern = class("game.bullets.MultiPattern", BulletPattern)

function MultiPattern:initialize(patterns)
	self.patterns = patterns
end

function MultiPattern:reset()
	for i,v in ipairs(self.patterns) do
		v:reset()
	end
end

function MultiPattern:update(dt)
	for i,v in ipairs(self.patterns) do
		v:update(dt)
	end
end

return MultiPattern

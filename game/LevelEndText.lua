local LevelEndText = class("game.LevelEndText", prox.Entity)

function LevelEndText:enter(level)
	self.level = level
end

return LevelEndText

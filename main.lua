prox = require("prox")
HC = require("HC")
settings = {
	screen_width = 320,
	screen_height = 480
}

function prox.load()
	prox.window.setSize(640, 480)
	prox.window.setScale(2)

	prox.gamestate.switch({require("game.Controller")("data/levels/1.lua")})
end

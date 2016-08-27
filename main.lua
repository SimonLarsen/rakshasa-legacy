prox = require("prox")
HC = require("HC")

function prox.load()
	prox.window.setSize(320, 480)
	prox.window.setScale(2)

	prox.gamestate.switch({require("game.Controller")()})
end

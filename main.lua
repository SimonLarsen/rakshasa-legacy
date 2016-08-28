prox = require("prox")
HC = require("HC")
settings = {
	screen_width = 320,
	screen_height = 480
}

function prox.load()
	prox.window.setSize(640, 480)
	prox.window.setScale(2)

	-- Preload fonts
	prox.resources.getImageFont("data/fonts/small.png", " 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ.,:;-?!'*")
	prox.resources.getImageFont("data/fonts/banner_font.png", " -0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz", 1)

	prox.gamestate.switch({require("game.Controller")("data/levels/2.lua")})
end

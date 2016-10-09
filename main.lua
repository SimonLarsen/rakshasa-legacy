prox = require("prox")
HC = require("HC")

settings = {
	screen_width = 320,
	screen_height = 480,
	scale = 2,
	fullscreen = false,
	fullscreen_mode = "scale"
}

highscore = {
	score = 0
}

function loadSettings()
	if not love.filesystem.exists("settings") then
		print("No settings file found. Using default settings.")
		return
	end

	local data = love.filesystem.read("settings")
	local file_settings = prox.serialize.unpack(data)

	for i,v in pairs(settings) do
		if file_settings[i] ~= nil then
			settings[i] = file_settings[i]
		end
	end
end

function saveSettings()
	local data = prox.serialize.pack(settings)
	love.filesystem.write("settings", data)
end

function loadHighscore()
	if not love.filesystem.exists("highscore") then
		return
	end

	local data = love.filesystem.read("highscore")
	local file_highscore = prox.serialize.unpack(data)

	if file_highscore.score then
		highscore.score = file_highscore.score
	end
end

function saveHighscore()
	local data = prox.serialize.pack(highscore)
	love.filesystem.write("highscore", data)
end

function prox.load()
	loadSettings()
	loadHighscore()

	prox.window.set(640, 480, true, settings.scale, settings.fullscreen, settings.fullscreen_mode)

	-- Preload fonts
	prox.resources.getImageFont("data/fonts/small.png", " 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ.,:;-?!'*")
	prox.resources.getImageFont("data/fonts/banner_font.png", " -0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz", 1)
	prox.resources.getImageFont("data/fonts/serif.png", " -0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz", 1)
	prox.resources.getImageFont("data/fonts/large_sans.png", " ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789", 2)

	prox.gamestate.switch({
		require("title.Controller")(),
		require("game.HexGrid")(),
		require("game.Background")(),
		require("game.ScreenBorder")()
	})
end

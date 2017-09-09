prox = require("prox")
HC = require("HC")

settings = {
	screen_width = 320,
	screen_height = 480,
	scale = 2,
	fullscreen = false,
	fullscreen_mode = "scale",
	ship_switch = true
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

function initBindings()
	local bindings = {}
	for i,v in ipairs(love.joystick.getJoysticks()) do
		if v:isGamepad() then
			local joystick = prox.JoystickBinding(i)
			joystick:add("confirm", "a")
			joystick:add("up", "dpup")
			joystick:add("down", "dpdown")
			joystick:add("left", "dpleft")
			joystick:add("right", "dpright")
			joystick:add("leftshoot", "leftshoulder")
			joystick:add("rightshoot", "rightshoulder")
			joystick:add("leftretract", "leftstick")
			joystick:add("rightretract", "rightstick")
			table.insert(bindings, joystick)
		end
	end

	local keyboard = prox.KeyboardBinding()
	keyboard:add("confirm", "return")
	keyboard:add("up", "up")
	keyboard:add("down", "down")
	keyboard:add("left", "left")
	keyboard:add("right", "right")
	keyboard:add("leftshoot", "lshift")
	keyboard:add("rightshoot", "-")
	keyboard:add("leftretract", "e")
	keyboard:add("rightretract", "u")
	keyboard:addAxis("leftx", "a", "d")
	keyboard:addAxis("lefty", "w", "s")
	keyboard:addAxis("rightx", "j", "l")
	keyboard:addAxis("righty", "i", "k")
	keyboard:addAxis("triggerleft", nil, nil)
	keyboard:addAxis("triggerright", nil, "space")
	table.insert(bindings, keyboard)

	return prox.MultiBinding(bindings)
end

function prox.load()
	loadSettings()
	loadHighscore()

	local binding = initBindings()

	-- Initialize window
	prox.window.set(640, 480, true, settings.scale, settings.fullscreen, settings.fullscreen_mode)

	-- Preload fonts
	prox.resources.getImageFont("data/fonts/small.png", " 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ.,:;-?!'*")
	prox.resources.getImageFont("data/fonts/banner_font.png", " -0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz", 1)
	prox.resources.getImageFont("data/fonts/serif.png", " -0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz", 1)
	prox.resources.getImageFont("data/fonts/large_sans.png", " ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789", 2)

	prox.gamestate.switch({
		require("title.Controller")(binding),
		require("bg.Background")(),
		--require("bg.ScreenBorder")(),
		require("bg.Painting")(),
		require("Debugging")()
	})

	prox.gamestate.current():getCamera():setPosition(settings.screen_width/2, settings.screen_height/2)
end

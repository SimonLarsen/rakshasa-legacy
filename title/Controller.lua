local music = require("music")

local Controller = class("title.Controller", prox.Entity)

local options = {
	"START",
	"CONFIG",
	"QUIT"
}

function Controller:enter()
	self:setName("titlecontroller")
	self:reset()

	self.ready = false
	self.selection = 1

	local joystick = prox.JoystickBinding(1)
	joystick:add("confirm", "a")
	joystick:add("up", "dpup")
	joystick:add("down", "dpdown")
	joystick:add("left", "dpleft")
	joystick:add("right", "dpright")
	joystick:add("leftshoot", "leftshoulder")
	joystick:add("rightshoot", "rightshoulder")

	local keyboard = prox.KeyboardBinding()
	keyboard:add("confirm", "return")
	keyboard:add("up", "up")
	keyboard:add("down", "down")
	keyboard:add("left", "left")
	keyboard:add("right", "right")
	keyboard:add("leftshoot", "lshift")
	keyboard:add("rightshoot", "-")
	keyboard:addAxis("leftx", "a", "d")
	keyboard:addAxis("lefty", "w", "s")
	keyboard:addAxis("rightx", "j", "l")
	keyboard:addAxis("righty", "i", "k")
	keyboard:addAxis("triggerleft", nil, "e")
	keyboard:addAxis("triggerright", nil, "u")

	self.binding = prox.MultiBinding({joystick,keyboard})

	self.title_image = prox.resources.getImage("data/images/title.png")

	self.serif_font = prox.resources.getImageFont("data/fonts/serif.png")
	self.sans_font = prox.resources.getImageFont("data/fonts/large_sans.png")

	self.sfx_blip = prox.resources.getSound("data/sounds/blip.wav")
	self.sfx_confirm = prox.resources.getSound("data/sounds/weird_bang.wav")

	local AnimatedModel = require("bg.AnimatedModel")
	prox.timer.every(1, function()
		local c = AnimatedModel("data/models/cube.obj", {
			x = 4*love.math.random()-2, y = -5, z = 8,
			desty = 5,
			rx = 0.5,
			ry = 0.5,
			speed = 2
		})
		self:getScene():add(c)
		c:setRotation(love.math.random(), love.math.random())
	end)
end

function Controller:update(dt, rt)
	local yaxis = self.binding:getAxis("lefty")

	if self.ready then
		if self.binding:wasPressed("down") then
			self.selection = prox.math.wrap(self.selection + 1, 1, #options)
			self.sfx_blip:play()
		elseif self.binding:wasPressed("up") then
			self.selection = prox.math.wrap(self.selection - 1, 1, #options)
			self.sfx_blip:play()
		end
	end

	if self.ready and self.binding:wasPressed("confirm") then
		self.sfx_confirm:play()
		if options[self.selection] == "START" then
			self:hide()
			music.stop()
			self:getScene():add(require("game.Controller")(2, self.binding))
		elseif options[self.selection] == "CONFIG" then
			self:hide()
			self:getScene():add(require("title.OptionsMenu")(self.binding))
		elseif options[self.selection] == "QUIT" then
			self:hide()
			prox.timer.after(1, function() love.event.quit() end)
		end
	end
end

function Controller:gui()
	love.graphics.setColor(255, 255, 255, self.title_alpha)
	love.graphics.draw(self.title_image, prox.window.getWidth()/2, self.title_y, 0, 1, 1, 159, 28)

	local midx = prox.window.getWidth()/2

	love.graphics.setFont(self.sans_font)
	for i,v in ipairs(options) do
		local alpha = prox.math.cap(self.menu_alpha - math.abs(i-self.selection)*80, 0, 255)
		love.graphics.setColor(255, 255, 255, alpha)
		love.graphics.printf(v, midx-149, 260+(i-1)*30, 300, "center")

		if self.ready and self.selection == i then
			local w = self.sans_font:getWidth(v)
			love.graphics.line(midx-150, 268+(i-1)*30, midx-w/2-14, 268+(i-1)*30)
			love.graphics.line(midx+150, 268+(i-1)*30, midx+w/2+14, 268+(i-1)*30)
		end
	end

	love.graphics.setColor(255, 255, 255, 255)
end

function Controller:reset(keep_music)
	self:setEnabled(true)

	if not keep_music then
		music.playFile("data/music/dots.ogg")
	end

	self.title_y = 172
	self.title_alpha = 0
	prox.timer.after(1, function()
		prox.timer.tween(2, self, {title_y = 164, title_alpha = 255}, "out-cubic")
	end)

	self.menu_alpha = 0
	prox.timer.after(2, function()
		prox.timer.tween(2, self, {menu_alpha = 255 + (#options-1)*80}, "out-quad")
	end)

	prox.timer.after(3, function() self.ready = true end)
end

function Controller:hide()
	self.ready = false

	prox.timer.clear()
	prox.timer.tween(1, self, {title_alpha = 0, menu_alpha = 0}, "out-quad",
		function()
			self:setEnabled(false)
		end
	)
end

function Controller:keepAlive()
	return true
end

return Controller

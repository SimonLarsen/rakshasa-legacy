local music = require("music")
local HexGrid = require("game.HexGrid")
local Background = require("game.Background")

local Controller = class("title.Controller", prox.Entity)

local options = {
	"START",
	"CONFIG",
	"QUIT"
}

function Controller:enter()
	self:setName("titlecontroller")
	self:reset()

	self:getScene():add(HexGrid())
	self:getScene():add(Background())
	self:getScene():getCamera():setPosition(settings.screen_width/2, settings.screen_height/2)

	self.ready = false
	self.selection = 1

	self.binding = prox.JoystickBinding(1)
	self.binding:add("confirm", "a")
	self.binding:add("up", "dpup")
	self.binding:add("down", "dpdown")
	self.binding:add("leftshoot", "leftshoulder")
	self.binding:add("rightshoot", "rightshoulder")
	--[[
	self.binding = prox.KeyboardBinding()
	self.binding:add("confirm", "return")
	self.binding:add("leftshoot", "lshift")
	self.binding:add("rightshoot", "-")
	self.binding:add("up", "up")
	self.binding:add("down", "down")
	self.binding:add("left", "left")
	self.binding:add("right", "right")
	self.binding:addAxis("leftx", "a", "d")
	self.binding:addAxis("lefty", "w", "s")
	self.binding:addAxis("rightx", "j", "l")
	self.binding:addAxis("righty", "i", "k")
	]]

	self.selection_image = prox.resources.getImage("data/images/selection_marker.png")
	self.border_image = prox.resources.getImage("data/images/border.png")
	self.title_image = prox.resources.getImage("data/images/title.png")

	self.serif_font = prox.resources.getImageFont("data/fonts/serif.png")
	self.sans_font = prox.resources.getImageFont("data/fonts/large_sans.png")
end

function Controller:update(dt, rt)
	local yaxis = self.binding:getAxis("lefty")

	if self.ready then
		if self.binding:wasPressed("down") then
			self.selection = prox.math.wrap(self.selection + 1, 1, #options)
		elseif self.binding:wasPressed("up") then
			self.selection = prox.math.wrap(self.selection - 1, 1, #options)
		end
	end

	if self.ready and self.binding:wasPressed("confirm") then
		music.stop()
		if options[self.selection] == "START" then
			self:getScene():add(require("game.Controller")("data/levels/1.lua", self.binding))
			self:hide()
		elseif options[self.selection] == "CONFIG" then
			self:getScene():add(require("title.OptionsMenu")(self.binding))
			self:hide()
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
	local bx1 = (prox.window.getWidth() - settings.screen_width) / 2 - self.border_image:getWidth()
	local bx2 = (prox.window.getWidth() + settings.screen_width) / 2

	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle("fill", 0, 0, bx1, prox.window.getHeight())
	love.graphics.rectangle("fill", bx2, 0, bx1, prox.window.getHeight())

	love.graphics.setColor(255, 255, 255, self.border_alpha)
	love.graphics.draw(self.border_image, bx1, 0, 0, 1, prox.window.getHeight())
	love.graphics.draw(self.border_image, bx2, 0, 0, 1, prox.window.getHeight())

	love.graphics.setFont(self.sans_font)
	for i,v in ipairs(options) do
		local alpha = prox.math.cap(self.menu_alpha - math.abs(i - self.selection)*80, 0, 255)
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

function Controller:reset()
	self:setEnabled(true)

	music.playFile("data/music/dots.ogg")

	self.border_alpha = 0
	prox.timer.tween(1, self, {border_alpha = 255}, "out-quad")

	self.title_y = 172
	self.title_alpha = 0
	prox.timer.after(1, function()
		prox.timer.tween(2, self, {title_y = 164, title_alpha = 255}, "out-cubic")
	end)

	self.menu_alpha = 0
	prox.timer.after(2, function()
		prox.timer.tween(2, self, {menu_alpha = 415}, "out-quad")
	end)

	prox.timer.after(3, function() self.ready = true end)
end

function Controller:hide()
	self.ready = false

	prox.timer.tween(1, self, {title_alpha = 0, menu_alpha = 0}, "out-quad",
		function()
			self:setEnabled(false)
		end
	)
end

return Controller

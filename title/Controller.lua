local HexLife = require("game.HexLife")

local Controller = class("title.Controller", prox.Entity)

function Controller:enter()
	self:setName("titlecontroller")
	self:reset()

	self:getScene():add(HexLife())

	self.border_image = prox.resources.getImage("data/images/border.png")
	self.title_image = prox.resources.getImage("data/images/title.png")
	self.prompt_image = prox.resources.getImage("data/images/title_button_prompt.png")

	self.serif_font = prox.resources.getImageFont("data/fonts/serif.png")
end

function Controller:update(dt, rt)
	if self.prompt_shown and prox.joystick.isDown(1, "leftshoulder") and prox.joystick.isDown(1, "rightshoulder") then
		self.prompt_shown = false
		self.border_alpha = 0
		self:getScene():add(require("game.Controller")("data/levels/1.lua"))
		prox.timer.tween(1, self, {title_alpha = 0, prompt_alpha = 0}, "out-quad",
			function()
				self:setEnabled(false)
			end
		)
	end
end

function Controller:gui()
	love.graphics.setColor(255, 255, 255, self.title_alpha)
	love.graphics.draw(self.title_image, prox.window.getWidth()/2, self.title_y, 0, 1, 1, 159, 28)

	local bx1 = (prox.window.getWidth() - settings.screen_width) / 2 - self.border_image:getWidth()
	local bx2 = (prox.window.getWidth() + settings.screen_width) / 2 + 1

	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle("fill", 0, 0, bx1, prox.window.getHeight())
	love.graphics.rectangle("fill", bx2, 0, bx1, prox.window.getHeight())

	love.graphics.setColor(255, 255, 255, self.border_alpha)
	love.graphics.draw(self.border_image, bx1, 0, 0, 1, prox.window.getHeight())
	love.graphics.draw(self.border_image, bx2, 0, 0, 1, prox.window.getHeight())

	love.graphics.setColor(255, 255, 255, self.prompt_alpha)
	love.graphics.draw(self.prompt_image, prox.window.getWidth()/2, self.prompt_y, 0, 1, 1, 99, 25)

	love.graphics.setColor(255, 255, 255, 255)
end

function Controller:reset()
	self.border_alpha = 0
	prox.timer.tween(1, self, {border_alpha = 255}, "out-quad")

	self.title_y = 170
	self.title_alpha = 0
	prox.timer.after(1, function()
		prox.timer.tween(2, self, {title_y = 164, title_alpha = 255}, "out-cubic")
	end)

	self.prompt_y = 282
	self.prompt_alpha = 0
	self.prompt_shown = false
	prox.timer.after(2, function()
		prox.timer.tween(1, self, {prompt_y = 276, prompt_alpha = 255}, "out-quad", function() self.prompt_shown = true end)
	end)
end

return Controller

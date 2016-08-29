local HexLife = require("game.HexLife")

local Controller = class("title.Controller", prox.Entity)

local options = {
	"START",
	"CONFIG",
	"QUIT"
}

function Controller:enter()
	self:setName("titlecontroller")
	self:reset()

	self:getScene():add(HexLife())

	self.ready = false
	self.stick_active = false
	self.selection = 1
	self.joystick = prox.JoystickBinding(1)
	self.joystick:add("confirm", "a")
	self.joystick:add("up", "dpup")
	self.joystick:add("down", "dpdown")

	self.selection_image = prox.resources.getImage("data/images/selection_marker.png")
	self.border_image = prox.resources.getImage("data/images/border.png")
	self.title_image = prox.resources.getImage("data/images/title.png")

	self.serif_font = prox.resources.getImageFont("data/fonts/serif.png")
	self.sans_font = prox.resources.getImageFont("data/fonts/large_sans.png")
end

function Controller:update(dt, rt)
	local yaxis = self.joystick:getAxis("lefty")

	local stick_active_before = self.stick_active
	self.stick_active = math.abs(yaxis) > 0.8

	if self.ready then
		if self.stick_active and not stick_active_before then
			self.selection = prox.math.cap(self.selection + prox.math.sign(yaxis), 1, #options)
		elseif self.joystick:wasPressed("down") then
			self.selection = prox.math.cap(self.selection + 1, 1, #options)
		elseif self.joystick:wasPressed("up") then
			self.selection = prox.math.cap(self.selection - 1, 1, #options)
		end
	end

	if self.ready and self.joystick:wasPressed("confirm") then
		if self.selection == 1 then
			self:getScene():add(require("game.Controller")("data/levels/2.lua"))
			self:hide()
		elseif self.selection == 2 then

		elseif self.selection == 3 then
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
	local bx2 = (prox.window.getWidth() + settings.screen_width) / 2 + 1

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

local ScreenBorder = class("bg.ScreenBorder", prox.Entity)

function ScreenBorder:enter()
	self.alpha = 0

	prox.timer.after(0.2, function()
		prox.timer.tween(1, self, {alpha = 255}, "out-quad")
	end)

	self.border_image = prox.resources.getImage("data/images/border.png")
end

function ScreenBorder:gui()
	local bx1 = (prox.window.getWidth() - settings.screen_width) / 2 - self.border_image:getWidth()
	local bx2 = (prox.window.getWidth() + settings.screen_width) / 2

	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle("fill", 0, 0, bx1, prox.window.getHeight())
	love.graphics.rectangle("fill", bx2, 0, bx1+1, prox.window.getHeight())

	love.graphics.setColor(255, 255, 255, self.alpha)
	love.graphics.draw(self.border_image, bx1, 0, 0, 1, prox.window.getHeight())
	love.graphics.draw(self.border_image, bx2, 0, 0, 1, prox.window.getHeight())
	love.graphics.setColor(255, 255, 255, 255)
end

function ScreenBorder:keepAlive()
	return true
end

return ScreenBorder

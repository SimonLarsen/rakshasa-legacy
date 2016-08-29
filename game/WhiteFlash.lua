local WhiteFlash = class("game.WhiteFlash", prox.Entity)

function WhiteFlash:enter(time, tween_function)
	self.alpha = 255
	prox.timer.tween(time, self, {alpha = 0}, tween_function, function() self:remove() end)
end

function WhiteFlash:gui()
	love.graphics.setColor(255, 255, 255, self.alpha)
	love.graphics.rectangle("fill", (prox.window.getWidth()-settings.screen_width)/2, 0, settings.screen_width, settings.screen_height)
	love.graphics.setColor(255, 255, 255, 255)
end

return WhiteFlash

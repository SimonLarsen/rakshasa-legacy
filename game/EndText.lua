local EndText = class("game.EndText", prox.Entity)

function EndText:enter(stage, level)
	self.box_alpha = 0
	self.text1_alpha = 0
	self.text2_alpha = 0
	self.z = 0

	prox.timer.tween(0.01, self, {box_alpha = 255}, "out-quad")

	prox.timer.after(1.0, function()
		prox.timer.tween(1.0, self, {text1_alpha = 255}, "out-quad")
	end)
	prox.timer.after(2.3, function()
		prox.timer.tween(1.5, self, {text2_alpha = 255}, "out-quad")
	end)

	prox.timer.after(5, function()
		prox.timer.tween(2.0, self, {box_alpha = 0, text1_alpha = 0, text2_alpha = 0}, "out-quad", function()
			self:remove()
		end)
	end)
end

function EndText:gui()
	local midx = prox.window.getWidth()/2
	local midy = prox.window.getHeight()/2

	love.graphics.setColor(255, 255, 255, self.box_alpha)
	love.graphics.rectangle("fill", midx-160, 0, settings.screen_width, settings.screen_height)

	love.graphics.setColor(255, 255, 255, 255)
end

return EndText

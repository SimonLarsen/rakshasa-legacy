local EndText = class("game.EndText", prox.Entity)

local number_names = {
	"first", "second", "third"
}

local level_names = {
	"fear", "vanity", "self"
}

function EndText:enter(level)
	self.box_alpha = 0
	self.text1_alpha = 0
	self.text2_alpha = 0
	self.z = 0

	self.img_number = prox.resources.getImage("data/images/endtext_" .. number_names[level] .. ".png")
	self.img_trans = prox.resources.getImage("data/images/endtext_transcendence.png")
	self.img_level = prox.resources.getImage("data/images/endtext_" .. level_names[level] .. ".png")

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

	love.graphics.setColor(0, 0, 0, self.text1_alpha)

	love.graphics.draw(self.img_number, midx, midy-36, 0, 1, 1, math.floor(self.img_number:getWidth()/2), self.img_number:getHeight())
	love.graphics.draw(self.img_trans, midx, midy, 0, 1, 1, math.floor(self.img_trans:getWidth()/2), self.img_trans:getHeight())

	love.graphics.setColor(0, 0, 0, self.text2_alpha)

	love.graphics.draw(self.img_level, midx, midy+60, 0, 1, 1, math.floor(self.img_level:getWidth()/2), self.img_level:getHeight())

	love.graphics.setColor(255, 255, 255, 255)
end

return EndText

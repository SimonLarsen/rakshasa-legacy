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
	self.z = 50

	self.img_number = prox.resources.getImage("data/images/endtext_" .. number_names[level] .. ".png")
	self.img_trans = prox.resources.getImage("data/images/endtext_transcendence.png")
	self.img_level = prox.resources.getImage("data/images/endtext_" .. level_names[level] .. ".png")

	prox.timer.tween(1.0, self, {box_alpha = 255}, "out-quad")
	prox.timer.after(0.5, function()
		prox.timer.tween(1.0, self, {text1_alpha = 255}, "out-quad")
	end)
	prox.timer.after(1.5, function()
		prox.timer.tween(1.0, self, {text2_alpha = 255}, "out-quad")
	end)

	prox.timer.after(4, function()
		prox.timer.tween(1, self, {box_alpha = 0, text1_alpha = 0, text2_alpha = 0}, "out-quad", function()
			self:remove()
		end)
	end)
end

function EndText:draw()
	local midx = settings.screen_width/2
	local midy = settings.screen_height/2

	love.graphics.setColor(0, 0, 0, self.box_alpha)
	love.graphics.rectangle("fill", 0, 0, settings.screen_width, settings.screen_height)

	love.graphics.setColor(255, 255, 255, self.text1_alpha)

	love.graphics.draw(self.img_number, midx, midy-36, 0, 1, 1, math.floor(self.img_number:getWidth()/2), self.img_number:getHeight())
	love.graphics.draw(self.img_trans, midx, midy, 0, 1, 1, math.floor(self.img_trans:getWidth()/2), self.img_trans:getHeight())

	love.graphics.setColor(255, 255, 255, self.text2_alpha)

	love.graphics.draw(self.img_level, midx, midy+60, 0, 1, 1, math.floor(self.img_level:getWidth()/2), self.img_level:getHeight())

	love.graphics.setColor(255, 255, 255, 255)
end

return EndText

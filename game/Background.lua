local Background = class("game.Background", prox.Entity)

local SCROLL_SPEED = 10

function Background:enter()
	self.z = 100
	self:setName("background")
	self.image = prox.resources.getImage("data/images/background_layer.png")
end

function Background:update(dt, rt)
	self.y = self.y + SCROLL_SPEED * dt
	if self.y > self.image:getHeight() then
		self.y = self.y - self.image:getHeight()
	end
end

function Background:draw()
	local alpha = 15 + 5*math.cos(prox.time.getTime()*4)
	love.graphics.setColor(255, 255, 255, alpha)
	love.graphics.draw(self.image, 0, self.y)
	love.graphics.draw(self.image, 0, self.y-self.image:getHeight())
	love.graphics.setColor(255, 255, 255, 255)
end

function Background:keepAlive()
	return true
end

return Background

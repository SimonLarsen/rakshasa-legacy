local Background = class("game.Background", prox.Entity)

local SCROLL_SPEED = 10

local files = {
	"data/images/background1.png",
	"data/images/background2.png",
}

function Background:enter(lvl)
	self:setName("background")
	self:set(lvl)
	self.alpha = 0
	prox.timer.tween(2, self, {alpha = 15}, "out-cubic")
end

function Background:update(dt, rt)
	self.y = self.y + SCROLL_SPEED * dt
	if self.y > self.image:getHeight() then
		self.y = self.y - self.image:getHeight()
	end
end

function Background:set(lvl)
	self.z = 100
	self.image = prox.resources.getImage(files[lvl])
end

function Background:draw()
	local alpha = self.alpha + 5*math.cos(prox.time.getTime()*4)
	love.graphics.setColor(255, 255, 255, alpha)
	love.graphics.draw(self.image, 0, self.y)
	love.graphics.draw(self.image, 0, self.y-self.image:getHeight())
	love.graphics.setColor(255, 255, 255, 255)
end

function Background:keepAlive()
	return true
end

return Background

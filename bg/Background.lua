local Background = class("bg.Background", prox.Entity)

local SCROLL_SPEED = 100

local files = {
	"data/images/backgrounds/background1.png",
	"data/images/backgrounds/background2.png",
	"data/images/backgrounds/background3.png"
}

function Background:enter(lvl, speed)
	self:setName("background")
	self.z = 200
	self:set(lvl)
	self.speed = speed or SCROLL_SPEED
	self.alpha = 0
	prox.timer.tween(5, self, {alpha = 1}, "out-cubic")
end

function Background:update(dt, rt)
	self.y = self.y + self.speed * dt
	if self.y > self.image:getHeight() then
		self.y = self.y - self.image:getHeight()
	end
end

function Background:set(lvl)
	self.image = prox.resources.getImage(files[lvl])
end

function Background:draw()
	local alpha = self.alpha * (20 + 5*math.cos(prox.time.getTime()*4))
	love.graphics.setColor(255, 255, 255, alpha)
	love.graphics.draw(self.image, 0, self.y)
	love.graphics.draw(self.image, 0, self.y-self.image:getHeight())
	love.graphics.setColor(255, 255, 255, 255)
end

function Background:keepAlive()
	return true
end

return Background

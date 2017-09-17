local ShipGhost = class("game.ShipGhost", prox.Entity)

ShipGhost.static.TIME = 0.2

function ShipGhost:enter(x, y, time)
	self.x = x
	self.y = y
	self.total_time = time or ShipGhost.static.TIME
	self.time = self.total_time

	self.sprite = prox.Sprite("data/images/ship_ghost.png", 19, 27)
end

function ShipGhost:update(dt, rt)
	self.time = self.time - dt
	if self.time <= 0 then
		self:remove()
	end
end

function ShipGhost:draw()
	love.graphics.setColor(255, 255, 255, self.time/self.total_time*128)
	self.sprite:draw(self.x, self.y)
	love.graphics.setColor(255, 255, 255, 255)
end

return ShipGhost

local Chain = class("game.Chain", prox.Entity)

function Chain:enter(ship1, ship2)
	self.z = 1

	self.ship1 = ship1
	self.ship2 = ship2

	self.center_sprite = prox.Sprite("data/images/chain_center.png")
	self.chain_link = prox.Sprite("data/images/chain_link.png", 4, 4)
end

function Chain:update(dt, rt)
	self.x = math.floor((self.ship1.x + self.ship2.x) / 2)
	self.y = math.floor((self.ship1.y + self.ship2.y) / 2)

	local dist = math.sqrt((self.ship1.x - self.ship2.x)^2 + (self.ship1.y - self.ship2.y)^2)
	self.ship1:getGearSprite():setRotation(dist / 48)
	self.ship2:getGearSprite():setRotation(dist / 48)
end

function Chain:draw()
	local xdist = (self.ship2.x - self.ship1.x) / 2
	local ydist = (self.ship2.y - self.ship1.y) / 2
	local dist = math.sqrt(xdist^2 + ydist^2)
	local count = dist / 9

	for i=0, count-1 do
		self.chain_link:draw(self.x + xdist * i / count, self.y + ydist * i / count)
		self.chain_link:draw(self.x - xdist * i / count, self.y - ydist * i / count)
	end

	self.center_sprite:draw(self.x, self.y)
end

return Chain

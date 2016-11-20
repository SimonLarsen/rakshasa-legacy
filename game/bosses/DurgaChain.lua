local DurgaChain = class("game.bosses.DurgaChain", prox.Entity)

function DurgaChain:enter(x, y, shield_offset, head_offset)
	self.z = 1
	self.shield_offset = shield_offset
	self.head_offset = head_offset

	self.gear = prox.Sprite("data/images/ship_gear.png", 19, 19)
	self.chain_link = prox.Sprite("data/images/chain_link_black.png", 4, 4)
end

function DurgaChain:draw()
	self.gear:setRotation((self.shield_offset-34) / 16)
	self.gear:draw(self.x-self.shield_offset-8, self.y+34)
	self.gear:draw(self.x+self.shield_offset+8, self.y+34)

	local count_left = (self.shield_offset + self.head_offset + 24) / 9
	local count_right = (self.shield_offset - self.head_offset + 24) / 9
	local mid_count = (2 * self.shield_offset) / 9

	for i=0, count_left-1, 1 do
		self.chain_link:draw(self.x+self.head_offset - i*9, self.y)
	end
	for i=0, count_right-1, 1 do
		self.chain_link:draw(self.x+self.head_offset + i*9, self.y)
	end

	for i=0, mid_count-1 do
		self.chain_link:draw(self.x-self.shield_offset + i*9, self.y+46)
	end
end

return DurgaChain

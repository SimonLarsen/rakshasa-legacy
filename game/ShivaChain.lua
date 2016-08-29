local ShivaChain = class("game.ShivaChain", prox.Entity)

local ENTER_TIME = 3

ShivaChain.static.SIDE_LEFT  = 1
ShivaChain.static.SIDE_RIGHT = 2

function ShivaChain:enter()
	self.y = -80
	self.z = 1
	self.head_x = 160
	self.arm_left_y = -80
	self.arm_right_y = -80

	self.hinge_left = prox.Sprite("data/images/shiva_hinge.png")
	self.hinge_right = prox.Sprite("data/images/shiva_hinge.png")
	self.hinge_right:setScale(-1, 1)

	self.gear = prox.Sprite("data/images/ship_gear.png", 19, 19)
	self.chain_link = prox.Sprite("data/images/chain_link_black.png", 4, 4)
end

function ShivaChain:draw()
	local count_top_left = math.max((self.head_x - 25 + 6) / 9)
	local count_top_right = math.max((settings.screen_width - 25 - self.head_x + 6) / 9)

	local count_left = (self.arm_left_y - self.y) / 9
	local count_right = (self.arm_right_y - self.y) / 9

	for i=0, count_top_left-1 do
		self.chain_link:draw(25 + i*9, self.y)
	end
	for i=0, count_top_right-1 do
		self.chain_link:draw(settings.screen_width-25 - i*9, self.y)
	end

	for i=0, count_left-1 do
		self.chain_link:draw(25, self.y + i*9)
	end
	for i=0, count_right-1 do
		self.chain_link:draw(settings.screen_width-25, self.y + i*9)
	end

	self.hinge_left:draw(25, self.y)
	self.hinge_right:draw(settings.screen_width - 25, self.y)

	self.gear:setRotation(self.head_x / 16)
	self.gear:draw(self.head_x-49, self.y+8)
	self.gear:draw(self.head_x+49, self.y+8)

	self.gear:setRotation((self.arm_left_y-self.y)/ 16)
	self.gear:draw(27, self.arm_left_y-9)

	self.gear:setRotation((self.arm_right_y-self.y) / 16)
	self.gear:draw(settings.screen_width-27, self.arm_right_y-9)
end

return ShivaChain

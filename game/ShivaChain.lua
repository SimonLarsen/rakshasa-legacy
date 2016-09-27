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

	self.hinge_left = prox.Animation("data/animations/shiva_hinge_left.lua")
	self.hinge_right = prox.Animation("data/animations/shiva_hinge_right.lua")

	self.gear = prox.Sprite("data/images/ship_gear.png", 19, 19)
	self.small_gear = prox.Sprite("data/images/small_gear.png")
	self.chain_link = prox.Sprite("data/images/chain_link_black.png", 4, 4)
end

function ShivaChain:update(dt, rt)
	self.hinge_left:update(dt)
	self.hinge_right:update(dt)
end

function ShivaChain:draw()
	local top_left = self.head_x - 25 + 6
	local top_right = settings.screen_width - 25 - self.head_x + 6
	local left_side = self.arm_left_y - self.y
	local right_side = self.arm_right_y - self.y

	local total_left = top_left + left_side
	local total_right = top_right + right_side

	local count_top_left = math.ceil(top_left / 9)
	local count_top_right = math.ceil(top_right / 9)

	local count_left = math.ceil(left_side / 9)
	local count_right = math.ceil(right_side / 9)

	for i=0, count_top_left-1 do
		self.chain_link:draw(self.head_x - (total_left % 9) - i*9, self.y)
	end
	for i=0, count_top_right-1 do
		self.chain_link:draw(self.head_x + (total_right % 9) + i*9, self.y)
	end

	for i=0, count_left-1 do
		self.chain_link:draw(25, self.y + (total_left % 9) + i*9)
	end
	for i=0, count_right-1 do
		self.chain_link:draw(settings.screen_width-25, self.y + (total_right % 9) + i*9)
	end

	self.gear:setRotation(self.head_x / 16)
	self.gear:draw(self.head_x-49, self.y+8)
	self.gear:draw(self.head_x+49, self.y+8)

	self.gear:setRotation(total_left / 16)
	self.small_gear:setRotation(total_left / 16)
	self.small_gear:draw(25, self.y)
	self.gear:draw(27, self.arm_left_y-9)

	self.gear:setRotation(total_right / 16)
	self.small_gear:setRotation(total_right / 16)
	self.small_gear:draw(settings.screen_width-27, self.y)
	self.gear:draw(settings.screen_width-27, self.arm_right_y-9)

	self.hinge_left:draw(25, self.y)
	self.hinge_right:draw(settings.screen_width - 25, self.y)
end

return ShivaChain

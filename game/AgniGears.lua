local AgniGears = class("game.AgniGears", prox.Entity)

function AgniGears:enter()
	self.z = 2

	self.agni_head_x = 160
	self.agni_head_y = -80
	self.agni_hand_left_x = 85
	self.agni_hand_left_y = -80
	self.agni_hand_right_x = 235
	self.agni_hand_right_y = -80

	self.gear = prox.Sprite("data/images/ship_gear.png", 19, 19)
end

function AgniGears:draw()
	self.gear:setRotation(self.agni_head_x / 16)
	self.gear:draw(self.agni_head_x-41, self.agni_head_y+19)
	self.gear:draw(self.agni_head_x+41, self.agni_head_y+19)

	self.gear:setRotation(math.sqrt(self.agni_hand_left_x^2 + self.agni_hand_left_y^2) / 16)
	self.gear:draw(self.agni_hand_left_x+12, self.agni_hand_left_y-8)

	self.gear:setRotation(math.sqrt(self.agni_hand_right_x^2 + self.agni_hand_right_y^2) / 16)
	self.gear:draw(self.agni_hand_right_x-12, self.agni_hand_right_y-8)
end

return AgniGears

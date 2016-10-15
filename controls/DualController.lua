local PlayerController = require("controls.PlayerController")

local DualController = class("controls.DualController", PlayerController)

function DualController:enter(binding, ship_left, ship_right, chain)
	PlayerController.enter(self, binding, ship_left, ship_right, chain)
end

function DualController:update(dt, rt)
	self.ship_left:setMovement(self.binding:getAxis("leftx"), self.binding:getAxis("lefty"))
	self.ship_right:setMovement(self.binding:getAxis("rightx"), self.binding:getAxis("righty"))

	if self.binding:isDown("leftshoot") then
		self.ship_left:shoot()
	end
	if self.binding:isDown("rightshoot") then
		self.ship_right:shoot()
	end

	if self.binding:wasPressed("leftpower") then
		self.ship_left:triggerPower()
	end
	if self.binding:wasPressed("rightpower") then
		self.ship_right:triggerPower()
	end
end

return DualController

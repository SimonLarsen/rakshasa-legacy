local PlayerController = require("controls.PlayerController")
local Ship = require("game.Ship")

local DualController = class("controls.DualController", PlayerController)

local SWITCH_COOLDOWN = 0.1
local SWITCH_MAX_SPEED = 10

function DualController:enter(binding, ship_left, ship_right, chain, switch)
	PlayerController.enter(self, binding, ship_left, ship_right, chain)

	self.switch = switch or false
	self.switch_cooldown = 0
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

	local leftsp = math.sqrt(self.ship_left.xspeed^2 + self.ship_left.yspeed^2)
	local rightsp = math.sqrt(self.ship_right.xspeed^2 + self.ship_right.yspeed^2)

	if leftsp < SWITCH_MAX_SPEED and rightsp < SWITCH_MAX_SPEED then
		self.switch_cooldown = self.switch_cooldown - rt
	else
		self.switch_cooldown = SWITCH_COOLDOWN
	end

	if self.switch and self.ship_left.x - self.ship_right.x > 10 and self.switch_cooldown <= 0 then
		self.ship_left, self.ship_right = self.ship_right, self.ship_left
		self.ship_left:setSide(Ship.static.SIDE_LEFT)
		self.ship_right:setSide(Ship.static.SIDE_right)
	end
end

return DualController

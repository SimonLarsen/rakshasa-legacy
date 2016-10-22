local PlayerController = require("controls.PlayerController")

local PivotController = class("controls.PivotController", PlayerController)

function PivotController:enter(binding, ship_left, ship_right, chain)
	PlayerController.enter(self, binding, ship_left, ship_right, chain)

	self.old_triggerright = 0
end

function PivotController:update(dt, rt)
	local leftx = self.binding:getAxis("leftx")
	local lefty = self.binding:getAxis("lefty")

	local rightx = self.binding:getAxis("leftx")
	local righty = self.binding:getAxis("lefty")

	local xdist = self.ship_right.x - self.ship_left.x
	local ydist = self.ship_right.y - self.ship_left.y
	local dist = math.sqrt(xdist^2 + ydist^2)

	-- handle separation
	local sep = self.binding:getAxis("righty")
	leftx = leftx + xdist / dist * sep
	lefty = lefty + ydist / dist * sep
	rightx = rightx - xdist / dist * sep
	righty = righty - ydist / dist * sep

	local rot = self.binding:getAxis("rightx")
	local angle = math.atan2(ydist, xdist) + rot * 0.5

	leftx = leftx + math.sin(angle) * rot
	lefty = lefty - math.cos(angle) * rot
	rightx = rightx - math.sin(angle) * rot
	righty = righty + math.cos(angle) * rot

	local leftnorm = math.sqrt(leftx^2 + lefty^2)
	local rightnorm = math.sqrt(rightx^2 + righty^2)
	if leftnorm > 1 then
		leftx = leftx / leftnorm
		lefty = lefty / leftnorm
	end
	if rightnorm > 1 then
		rightx = rightx / rightnorm
		righty = righty / rightnorm
	end
	self.ship_left:setMovement(leftx, lefty)
	self.ship_right:setMovement(rightx, righty)

	if self.binding:isDown("leftpurity") then
		self.ship_left:purityBall()
	end
	if self.binding:isDown("rightpurity") then
		self.ship_right:purityBall()
	end

	if self.binding:getAxis("triggerright") >= 0.8 and self.old_trigger_right < 0.5 then
		self.chain:purityWave()
	end
	self.old_trigger_right = self.binding:getAxis("triggerright")
end

return PivotController

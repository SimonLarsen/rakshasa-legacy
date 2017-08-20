local Model = require("bg.Model")
local Monkey = class("bg.models.Monkey", Model)

function Monkey:enter()
	Model.enter(self, "data/models/distorted.obj", 0, 0, -4)

	self.time = 0

	self.rotx = 0
	self.roty = 0
end

function Monkey:update(dt, rt)
	self.time = self.time + dt

	local destz = -4.0 - (self.time % 1) / 3
	self.z = prox.math.movetowards(self.z, destz, 5*dt)
	self:setTranslation(self.x, self.y, self.z)

	self.rotx = self.rotx + dt*0.6
	self.roty = math.cos(self.time*0.6) * 0.25

	self:setRotation(self.rotx, self.roty, 0)
end

return Monkey

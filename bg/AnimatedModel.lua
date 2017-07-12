local cpml = require("cpml")
local Model = require("bg.Model")

local AnimatedModel = class("bg.AnimatedModel", Model)

function AnimatedModel:enter(path, options)
	Model.enter(self, path, options.x, options.y, options.z)

	self.destx = options.destx or self.x
	self.desty = options.desty or self.y
	self.destz = options.destz or self.z

	self.rx = options.rx
	self.ry = options.ry
	self.rz = options.rz

	local dx = self.destx - self.x
	local dy = self.desty - self.y
	local dz = self.destz - self.z
	local dist = math.sqrt(dx^2 + dy^2 + dz^2)

	self.speed = options.speed or 1
	self.xspeed = dx / dist * self.speed
	self.yspeed = dy / dist * self.speed
	self.zspeed = dz / dist * self.speed
end

function AnimatedModel:update(dt, rt)
	self:translate(self.xspeed*dt, self.yspeed*dt, self.zspeed*dt)

	if self.rx then self:rotate(self.rx*dt, cpml.vec3.unit_x) end
	if self.ry then self:rotate(self.ry*dt, cpml.vec3.unit_y) end
	if self.rz then self:rotate(self.rz*dt, cpml.vec3.unit_z) end

	local dx = self.destx - self.x
	local dy = self.desty - self.y
	local dz = self.destz - self.z

	if dx^2 + dy^2 + dz^2 < 0.001 then
		self:remove()
	end
end

return AnimatedModel

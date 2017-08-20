local cpml = require("cpml")
local Model = require("bg.Model")

local ModelAnimator = class("bg.ModelAnimator", prox.Entity)

function ModelAnimator:enter(model, options)
	if type(model) == "string" then
		self.model = self:getScene():add(Model(model))
	else
		self.model = model
	end

	self.model:setTranslation(options.x, options.y, options.z)

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

	self._move = false
	if options.destx or options.desty or options.destz then
		self.speed = options.speed or 1
		self.xspeed = dx / dist * self.speed
		self.yspeed = dy / dist * self.speed
		self.zspeed = dz / dist * self.speed
		self._move = true
	end

	self._remove = options.remove ~= false
end

function ModelAnimator:update(dt, rt)
	if self._move then
		self.model:translate(self.xspeed*dt, self.yspeed*dt, self.zspeed*dt)
	end

	if self.rx then self.model:rotate(self.rx*dt, cpml.vec3.unit_x) end
	if self.ry then self.model:rotate(self.ry*dt, cpml.vec3.unit_y) end
	if self.rz then self.model:rotate(self.rz*dt, cpml.vec3.unit_z) end

	local dx = self.destx - self.x
	local dy = self.desty - self.y
	local dz = self.destz - self.z

	if self._remove and dx^2 + dy^2 + dz^2 < 0.001 then
		self.model:remove()
		self:remove()
	end
end

function ModelAnimator:getModel()
	return self.model
end

return ModelAnimator

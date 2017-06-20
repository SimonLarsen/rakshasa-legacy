local cpml = require("cpml")
local WireModel = class("bg.WireModel", prox.Entity)

function WireModel:enter(path, x, y, z)
	self.m_pos = cpml.mat4()
	if x then
		self.m_pos:translate(self.m_pos, cpml.vec3(x, y or 0, z or 0))
	end
	self.m_rot = cpml.mat4()
	self.m_scale = cpml.mat4()

	self.data = {}
	for line in io.lines(path) do
		local parts = prox.string.split(line, "\t")
		local v1 = cpml.vec3(tonumber(parts[1]), tonumber(parts[2]), tonumber(parts[3]))
		local v2 = cpml.vec3(tonumber(parts[4]), tonumber(parts[5]), tonumber(parts[6]))
		table.insert(self.data, {v1, v2})
	end
end

function WireModel:setRotation(rx, ry, rz)
	identity(self.m_rot)
	self.m_rot:rotate(self.m_rot, rx, cpml.vec3.unit_x)
	self.m_rot:rotate(self.m_rot, ry, cpml.vec3.unit_y)
	self.m_rot:rotate(self.m_rot, rz, cpml.vec3.unit_z)
end

function WireModel:rotate(angle, axis)
	self.m_rot:rotate(self.m_rot, angle, axis)
end

function WireModel:setScale(s)
	self.m_scale[1] = s
	self.m_scale[6] = s
	self.m_scale[11] = s
	self.m_scale[16] = s
end

function WireModel:setTranslation(x, y, z)
	cpml.identity(self.m_pos)
	self:translate(x, y, z)
end

function WireModel:translate(x, y, z)
	self.m_pos:translate(self.m_pos, cpml.vec3(x, y, z))
end

function WireModel:getTransform()
	return self.m_scale * self.m_rot * self.m_pos
end

function WireModel:getData()
	return self.data
end

return WireModel

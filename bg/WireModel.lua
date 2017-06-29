local cpml = require("cpml")
local WireModel = class("bg.WireModel", prox.Entity)

function WireModel:enter(path, x, y, z)
	self._m_pos = cpml.mat4()
	if x then
		self._m_pos:translate(self._m_pos, cpml.vec3(x, y or 0, z or 0))
	end
	self._m_rot = cpml.mat4()
	self._m_scale = cpml.mat4()

	self._data = {}
	for line in love.filesystem.lines(path) do
		local parts = prox.string.split(line, "\t")
		local v1 = cpml.vec3(tonumber(parts[1]), tonumber(parts[2]), tonumber(parts[3]))
		local v2 = cpml.vec3(tonumber(parts[4]), tonumber(parts[5]), tonumber(parts[6]))
		table.insert(self._data, {v1, v2})
	end
end

function WireModel:setRotation(rx, ry, rz)
	identity(self._m_rot)
	self._m_rot:rotate(self._m_rot, rx, cpml.vec3.unit_x)
	self._m_rot:rotate(self._m_rot, ry, cpml.vec3.unit_y)
	self._m_rot:rotate(self._m_rot, rz, cpml.vec3.unit_z)
end

function WireModel:rotate(angle, axis)
	self._m_rot:rotate(self._m_rot, angle, axis)
end

function WireModel:setScale(s)
	self._m_scale[1] = s
	self._m_scale[6] = s
	self._m_scale[11] = s
	self._m_scale[16] = s
end

function WireModel:setTranslation(x, y, z)
	cpml.identity(self._m_pos)
	self:translate(x, y, z)
end

function WireModel:translate(x, y, z)
	self._m_pos:translate(self._m_pos, cpml.vec3(x, y, z))
end

function WireModel:getTransform()
	return self._m_scale * self._m_rot * self._m_pos
end

function WireModel:getData()
	return self._data
end

return WireModel

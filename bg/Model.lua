local cpml = require("cpml")
local StaticModelData = require("bg.StaticModelData")

local Model = class("bg.Model", prox.Entity)

function Model:enter(model, x, y, z, culling, draw_edges)
	if type(model) == "string" then
		self._data = StaticModelData(model)
	else
		self._data = model
	end

	self._m_pos = cpml.mat4()
	self._m_rot = cpml.mat4()
	self._m_scale = cpml.mat4()
	self._culling = culling == true or culling == nil
	self._draw_edges = draw_edges == true or draw_edges == nil

	if x then
		self:setTranslation(x, y or 0, z or 0)
	end
end

function Model:update(dt, rt)
	self._data:update(dt, rt)
end

function Model:setTranslation(x, y, z)
	cpml.mat4.identity(self._m_pos)

	self.x = x
	self.y = y
	self.z = z

	self._m_pos[13] = x
	self._m_pos[14] = y
	self._m_pos[15] = z
end

function Model:translate(x, y, z)
	self.x = self.x + x
	self.y = self.y + y
	self.z = self.z + z

	self._m_pos[13] = self.x + x
	self._m_pos[14] = self.y + y
	self._m_pos[15] = self.z + z
end

function Model:setScale(sx, sy, sz)
	self._m_scale[1] = sx
	self._m_scale[6] = sy
	self._m_scale[11] = sz
end

function Model:scale(sx, sy, sz)
	self._m_scale[1] = self._m_scale[1] * sx
	self._m_scale[6] = self._m_scale[6] * sy
	self._m_scale[11] = self._m_scale[11] * sz
end

function Model:setRotation(rx, ry, rz)
	cpml.mat4.identity(self._m_rot)
	if rx then self._m_rot:rotate(self._m_rot, rx, cpml.vec3.unit_x) end
	if ry then self._m_rot:rotate(self._m_rot, ry, cpml.vec3.unit_y) end
	if rz then self._m_rot:rotate(self._m_rot, rz, cpml.vec3.unit_z) end
end

function Model:rotate(angle, axis)
	self._m_rot:rotate(self._m_rot, angle, axis)
end

function Model:getTransform()
	return self._m_scale * self._m_rot * self._m_pos
end

function Model:getData()
	return self._data
end

function Model:getCulling()
	return self._culling
end

function Model:setDrawEdges(v)
	self._draw_edges = v
end

function Model:getDrawEdges()
	return self._draw_edges
end

return Model

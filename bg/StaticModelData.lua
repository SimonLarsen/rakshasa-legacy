local ModelData = require("bg.ModelData")
local obj_reader = require("lua-obj-reader/obj-reader")

local StaticModelData = class("bg.StaticModelData", ModelData)

function StaticModelData:initialize(path)
	local data = obj_reader.read(path)
	self._vertices = data.v
	self._faces = data.f
	self._normals = data.vn
	self._materials = data.materials
end

function StaticModelData:getVertices()
	return self._vertices
end

function StaticModelData:getFaces()
	return self._faces
end

function StaticModelData:getNormals()
	return self._normals
end

function StaticModelData:getMaterials()
	return self._materials
end

return StaticModelData

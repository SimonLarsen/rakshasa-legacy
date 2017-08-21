local ModelData = require("bg.ModelData")

local StaticModelData = class("bg.StaticModelData", ModelData)

function StaticModelData:initialize(vertices, faces, normals, materials)
	self._vertices = vertices
	self._faces = faces
	self._normals = normals
	self._materials = materials
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

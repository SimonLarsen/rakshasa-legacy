local ModelData = require("bg.ModelData")

local StaticModelData = class("bg.StaticModelData", ModelData)

function StaticModelData:initialize(vertices, faces, normals)
	self._vertices = vertices
	self._faces = faces
	self._normals = normals
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

return StaticModelData

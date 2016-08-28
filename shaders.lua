local serialize = require("prox.serialize")

local shader_objects = {}

local shaders = {}

function shaders.getShader(path)
	if shader_objects[path] == nil then
		local data = serialize.read(path)
		shader_objects[path] = love.graphics.newShader(data.pixelcode, data.vertexcode)
	end

	return shader_objects[path]
end

return shaders

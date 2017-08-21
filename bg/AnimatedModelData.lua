local ModelData = require("bg.ModelData")

local AnimatedModelData = class("bg.AnimatedModelData", ModelData)

function AnimatedModelData:initialize(paths, delays, speed)
	assert(#paths == #delays-1, "Number of delays must be equal to number of frames minus one.")

	self._models = {}
	self._delays = delays
	self._speed = speed or 1
	self._time = 0
	self._frame = 1
	self._vertices = {}

	for i,v in ipairs(paths) do
		if type(v) == "string" then
			local m = self:getScene():add(Model(v))
			table.insert(self._models, m)
		else
			table.insert(self._models, v)
		end
	end

	self._frames = #self._models
end

function AnimatedModelData:update(dt, rt)
	self._time = self._time + dt*self._speed

	if self._time >= self._delays[self._frame] then
		self._time = self._time - self._delays[self._frame]
		self._frame = self._frame + 1
		if self._frame >= self._frames then
			self._frame = 1
		end
	end
end

function AnimatedModelData:getVertices(update)
	if update == nil or update == true then
		local step = self._time / self._delays[self._frame]

		local v1 = self._models[self._frame]:getVertices()
		local v2 = self._models[self._frame+2]:getVertices()

		for i=1, #self._models[self._frame] do
			self._vertices[i] = (1 - step) * v1[i] + step * v2[i]
		end
	end

	return self._vertices
end

function AnimatedModelData:getFaces()
	return self._models[1]:getFaces()
end

function AnimatedModelData:getNormals()
	return self._models[1]:getNormals()
end

return AnimatedModelData

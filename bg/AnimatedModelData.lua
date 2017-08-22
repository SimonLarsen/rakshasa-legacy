local ModelData = require("bg.ModelData")
local StaticModelData = require("bg.StaticModelData")

local AnimatedModelData = class("bg.AnimatedModelData", ModelData)

function AnimatedModelData:initialize(paths, delays, speed, mode)
	self._models = {}
	self._delays = delays
	self._speed = speed or 1
	self._time = 0
	self._frame = 1
	self._mode = mode or "forward"
	self._forward = true
	self._vertices = {}

	for i,v in ipairs(paths) do
		if type(v) == "string" then
			table.insert(self._models, StaticModelData(v))
		else
			table.insert(self._models, v)
		end
	end

	self._frames = #self._models
end

function AnimatedModelData:update(dt, rt)
	if self._forward then
		self._time = self._time + dt*self._speed

		if self._time >= self._delays[self._frame] then
			self._time = self._time - self._delays[self._frame]
			self._frame = self._frame + 1
			if self._frame >= self._frames then
				if self._mode == "pingpong" then
					self._forward = false
					self._frame = self._frames - 1
					self._time = self._delays[self._frame] - self._time
				else
					self._frame = 1
				end
			end
		end
	else
		self._time = self._time - dt*self._speed

		if self._time < 0 then
			self._frame = self._frame - 1
			if self._frame == 0 then
				self._frame = 1
				self._forward = true
				self._time = math.abs(self._time)
			else
				self._time = self._delays[self._frame] + self._time
			end
		end
	end
end

function AnimatedModelData:getVertices(update)
	if update == nil or update == true then
		local step = self._time / self._delays[self._frame]

		local v1 = self._models[self._frame]:getVertices()
		local v2 = self._models[self._frame+1]:getVertices()

		for i=1, #v1 do
			local x = (1 - step) * v1[i].x + step * v2[i].x
			local y = (1 - step) * v1[i].y + step * v2[i].y
			local z = (1 - step) * v1[i].z + step * v2[i].z
			self._vertices[i] = {x = x, y = y, z = z}
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

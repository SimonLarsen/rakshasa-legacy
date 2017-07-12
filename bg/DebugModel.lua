local cpml = require("cpml")
local Model = require("bg.Model")

local DebugModel = class("bg.DebugModel", Model)

function DebugModel:enter(path, x, y, z)
	Model.enter(self, path, x, y, z)
end

function DebugModel:update(dt, rt)
	if love.keyboard.isDown("w") then
		self:translate(0, -dt, 0)
	end
	if love.keyboard.isDown("s") then
		self:translate(0, dt, 0)
	end
	if love.keyboard.isDown("a") then
		self:translate(-dt, 0, 0)
	end
	if love.keyboard.isDown("d") then
		self:translate(dt, 0, 0)
	end

	if love.keyboard.isDown("i") then
		self:rotate(-dt, cpml.vec3.unit_x)
	end
	if love.keyboard.isDown("k") then
		self:rotate(dt, cpml.vec3.unit_x)
	end
	if love.keyboard.isDown("j") then
		self:rotate(-dt, cpml.vec3.unit_y)
	end
	if love.keyboard.isDown("l") then
		self:rotate(dt, cpml.vec3.unit_y)
	end
end

return DebugModel

local cpml = require("cpml")

local Wireframe = class("bg.Wireframe", prox.Entity)

function Wireframe:enter()
	self:setName("wireframe")
	self.z = 150

	self.m_proj = cpml.mat4().from_perspective(60, 1, 0.01, 100)

	self.models = {}
end

function Wireframe:draw()
	love.graphics.setLineWidth(1)
	love.graphics.setLineStyle("rough")

	local alpha = 20 + 5*math.cos(prox.time.getTime()*4)
	love.graphics.setColor(alpha, alpha, alpha, 255)

	for i=#self.models, 1, -1 do
		local v = self.models[i]
		if not v:isAlive() then
			table.remove(self.models, i)
		else
			local M = v:getTransform() * self.m_proj

			for j,p in ipairs(v:getData()) do
				local v1p = cpml.mat4.mul_vec4({}, M, {p[1].x, p[1].y, p[1].z, 1})
				local v2p = cpml.mat4.mul_vec4({}, M, {p[2].x, p[2].y, p[2].z, 1})

				local p1 = cpml.vec3(v1p[1], v1p[2], v1p[3]) / v1p[4] * 320 + cpml.vec3(160, 240, 0)
				local p2 = cpml.vec3(v2p[1], v2p[2], v2p[3]) / v2p[4] * 320 + cpml.vec3(160, 240, 0)

				love.graphics.line(p1.x, p1.y, p2.x, p2.y)
			end
		end
	end

	love.graphics.setColor(255, 255, 255, 255)
end

function Wireframe:addModel(m)
	table.insert(self.models, m)
end

function Wireframe:keepAlive()
	return true
end

return Wireframe

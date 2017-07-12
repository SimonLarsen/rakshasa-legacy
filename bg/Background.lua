local cpml = require("cpml")
local Model = require("bg.Model")

local Background = class("bg.Background", prox.Entity)

function Background:enter()
	self:setName("background")
	self.z = 150

	self.m_proj = cpml.mat4().from_perspective(60, 1, 0.01, 100)
	self.m_proj[12] = self.m_proj[12] * -1 -- flip z axis
end

function Background:update(dt, rt)
	
end

function Background:draw()
	love.graphics.setLineWidth(1)
	love.graphics.setLineStyle("rough")

	local offset = cpml.vec3(160, 240, 0)

	for _, model in ipairs(self:getScene():findAll(Model)) do
		local d = model:getData()
		local T = model:getTransform()
		local M = T * self.m_proj
		local Mti = cpml.mat4.invert(cpml.mat4(), M)
		Mti:transpose(Mti)

		-- temp. tables to reduce GC
		local pp, vnp, ref = {}, {}, {}

		-- transform vertices
		local vs = {}
		for _, p in ipairs(d.v) do
			local pp = cpml.mat4.mul_vec4(pp, M, {p.x, p.y, p.z, 1})
			local ppp = cpml.vec3(pp[1]/pp[4], pp[2]/pp[4], pp[3])
			table.insert(vs, ppp)
		end

		-- sort faces by distance
		local order = {}
		for i, f in ipairs(d.f) do
			local visible = false

			if model:getCulling() then
				-- transform normal vector
				local vn = d.vn[f[1].vn]
				local vnp = cpml.mat4.mul_vec4(vnp, T, {vn.x, vn.y, vn.z, 0})

				-- get reference vertex
				local vref = d.v[f[1].v]
				local ref = cpml.mat4.mul_vec4(ref, T, {vref.x, vref.y, vref.z, 1})

				local dot = cpml.vec3.dot(cpml.vec3(vnp[1], vnp[2], vnp[3]), cpml.vec3(ref[1], ref[2], ref[3]))
				visible = dot < 0
			else
				visible = true
			end

			if visible then
				-- distance to face is mean vertex position
				local mx, my, mz = 0, 0, 0
				for _, e in ipairs(f) do
					mx = mx + vs[e.v].x
					my = my + vs[e.v].y
					mz = mz + vs[e.v].z
				end
				local dist = (mx / #f)^2 + (my / #f)^2 + (mz / #f)^2
				table.insert(order, {i, dist})
			end
		end

		table.sort(order, function(a, b) return a[2] > b[2] end)

		for _, o in ipairs(order) do
			local f = d.f[o[1]]

			local poly = {}
			for _, e in ipairs(f) do
				table.insert(poly, vs[e.v].x * 320 + 160)
				table.insert(poly, vs[e.v].y * 320 + 240)
			end

			local r = 32 - math.min(math.log(o[2])*4, 32)
			love.graphics.setColor(r, r, r, 255)
			love.graphics.polygon("fill", poly)

			love.graphics.setColor(255, 255, 255, 255)
			j = 1
			while j <= #poly-3 do
				love.graphics.line(poly[j], poly[j+1], poly[j+2], poly[j+3])
				j = j + 2
			end
			love.graphics.line(poly[#poly-1], poly[#poly], poly[1], poly[2])
		end
	end
end

function Background:keepAlive()
	return true
end

return Background

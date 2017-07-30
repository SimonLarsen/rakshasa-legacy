local Slowable = require("game.Slowable")
local EnemyBullet = require("game.EnemyBullet")

local EnemyBulletExplosion = class("game.EnemyBulletExplosion", EnemyBullet)

local COLLISION_TIME = 0.1
local TIME = 0.4

function EnemyBulletExplosion:enter(x, y, radius)
	Slowable.enter(self)
	self.x = x
	self.y = y
	self.radius = radius
	self.collision_time = COLLISION_TIME
	self.time = TIME

	self.dissolve_shader = prox.resources.getShader("data/shaders/explosion_dissolve.glsl")
	local filter_image = prox.resources.getImage("data/images/textures/dissolve_waves2.png")
	self.dissolve_shader:send("filter", filter_image)
	self.dissolve_shader:send("radius", self.radius)
	self.dissolve_shader:send("cx", self.x+160)
	self.dissolve_shader:send("cy", self.y)

	self.hc_shape = HC.circle(0, 0, self.radius)
	self.hc_shape:moveTo(self.x, self.y)
end

function EnemyBulletExplosion:update(dt, rt)
	dt, rt = Slowable.update(self, dt, rt)

	self.collision_time = self.collision_time - dt
	if self.collision_time <= 0 then
		self.hc_shape = nil
	end

	self.time = self.time - dt
	if self.time <= 0 then
		self:remove()
	end
end

function EnemyBulletExplosion:draw()
	love.graphics.setLineWidth(2)
	if self.time > TIME-0.04 then
		love.graphics.setColor(0, 0, 0)
		love.graphics.circle("fill", self.x, self.y, self.radius*0.7, 64)
		love.graphics.setColor(211, 80, 80)
		love.graphics.circle("line", self.x, self.y, self.radius*0.7, 64)
	elseif self.time > TIME-0.08 then
		love.graphics.setColor(0, 0, 0)
		love.graphics.circle("fill", self.x, self.y, self.radius*0.85, 64)
		love.graphics.setColor(211, 80, 80)
		love.graphics.circle("line", self.x, self.y, self.radius*0.85, 64)
	elseif self.time > TIME-0.15 then
		love.graphics.setColor(255, 255, 255)
		love.graphics.circle("fill", self.x, self.y, self.radius*1.1, 64)
		love.graphics.setColor(211, 80, 80)
		love.graphics.circle("line", self.x, self.y, self.radius*1.1, 64)
	else
		love.graphics.setShader(self.dissolve_shader)
		local edge = (1 - self.time / TIME) * 1.2
		self.dissolve_shader:send("edge", edge)

		love.graphics.setColor(211, 80, 80)
		love.graphics.circle("fill", self.x, self.y, self.radius, 64)
		love.graphics.setColor(255, 255, 255)
		love.graphics.circle("line", self.x, self.y, self.radius, 64)
		love.graphics.setColor(255, 255, 255)

		love.graphics.setShader()
	end
	love.graphics.setLineWidth(1)
end

function EnemyBulletExplosion:getHCShape()
	return self.hc_shape
end

function EnemyBulletExplosion:kill()
	self:remove()
end

return EnemyBulletExplosion

local shaders = require("shaders")
local Slowable = require("game.Slowable")
local EnemyBullet = require("game.EnemyBullet")
local PurityDrone = require("game.PurityDrone")
local Purifier = require("game.Purifier")
local Gem = require("game.Gem")

local PurityBall = class("game.PurityBall", Purifier)

local RADIUS = 80

local TARGET_SPEED = 0.20
local TOTAL_TIME = 3.75
local IN_TIME = 0.25
local GROW_TIME = 0.4
local OUT_TIME = 0.5

function PurityBall:enter(x, y)
	self.x = x
	self.y = y
	self.z = 1
	self.speed = 1
	self.radius = 0
	self.alpha = 255

	prox.timer.tween(IN_TIME, self, {speed = TARGET_SPEED}, "out-quad")
	prox.timer.tween(GROW_TIME, self, {radius = RADIUS}, "in-out-cubic")

	self.timer = prox.timer.after(TOTAL_TIME-IN_TIME-OUT_TIME, function()
		self.timer = prox.timer.tween(OUT_TIME, self, {speed = 1.0, alpha = 0}, "in-quad", function()
			self:remove()
		end)
	end)

	self.shader = shaders.getShader("data/shaders/purity_ball.lua")
	self.shader:send("cx", self.x)
	self.shader:send("cy", self.y)
	self.shader:send("time", prox.time.getTime())
	local disp = prox.resources.getImage("data/images/textures/purify_disp.png")
	disp:setWrap("repeat","repeat")
	self.shader:send("disp", disp)
	prox.window.setShader(self.shader)

	self:getScene():add(PurityDrone(self.x, self.y, TOTAL_TIME, OUT_TIME))
end

function PurityBall:update(dt, rt)
	self.shader:send("time", prox.time.getTime())
	self.shader:send("radius", self.radius)
	self.shader:send("power", (1-self.speed)/(1-TARGET_SPEED))

	for i,v in ipairs(self:getScene():getEntities()) do
		if v:isInstanceOf(Slowable) then
			local dist = math.sqrt(math.pow(v.x - self.x, 2) + math.pow(v.y - self.y, 2))
			if dist <= self.radius then
				v:setTimeSpeed(self.speed)
			else
				v:setTimeSpeed(1.0)
			end
		end
	end
end

function PurityBall:trigger()
	for i,v in ipairs(self:getScene():getEntities()) do
		if v:isInstanceOf(EnemyBullet) then
			local dist = math.sqrt(math.pow(v.x - self.x, 2) + math.pow(v.y - self.y, 2))
			if dist <= self.radius then
				v:kill()
				self:getScene():add(Gem(v.x, v.y))
			end
		end
	end

	if self.timer then prox.timer.cancel(self.timer) end
	self:remove()
end

function PurityBall:draw()
	love.graphics.setColor(255, 255, 255, self.alpha)
	love.graphics.circle("line", self.x, self.y, self.radius, 64)
	love.graphics.setColor(255, 255, 255, 255)
end

function PurityBall:onRemove()
	for i,v in ipairs(self:getScene():getEntities()) do
		if v:isInstanceOf(Slowable) then
			v:setTimeSpeed(1.0)
		end
	end

	if self.timer then prox.timer.cancel(self.timer) end
	prox.window.setShader()
end

return PurityBall

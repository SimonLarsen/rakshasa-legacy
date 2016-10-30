local shaders = require("shaders")
local Slowable = require("game.Slowable")
local PurityDrone = require("game.PurityDrone")
local Purifier = require("game.Purifier")
local Gem = require("game.Gem")
local EnemyBullet = require("game.EnemyBullet")

local PurityWave = class("game.PurityWave", Purifier)

local TARGET_SPEED = 0.20
local TOTAL_TIME = 3.75
local IN_TIME = 0.25
local LINE_IN_TIME = 0.4
local OUT_TIME = 0.5

function PurityWave:enter(x1, y1, x2, y2)
	self.z = 1
	if x1 < x2 then
		self.leftx = x1
		self.lefty = y1
		self.rightx = x2
		self.righty = y2
	else
		self.leftx = x2
		self.lefty = y2
		self.rightx = x1
		self.righty = y1
	end

	self.width = self.rightx - self.leftx
	self.speed = 1
	self.line_length = 0
	self.alpha = 255

	prox.timer.tween(IN_TIME, self, {speed = TARGET_SPEED}, "out-quad")
	prox.timer.tween(LINE_IN_TIME, self, {line_length = 2*settings.screen_height}, "in-out-cubic")

	prox.timer.after(TOTAL_TIME-IN_TIME-OUT_TIME, function()
		prox.timer.tween(OUT_TIME, self, {speed = 1.0, alpha = 0}, "in-quad", function()
			self:remove()
		end)
	end)

	self.shader = shaders.getShader("data/shaders/purity_wave.lua")
	self.shader:send("left", self.leftx)
	self.shader:send("right", self.rightx)
	self.shader:send("time", prox.time.getTime())
	local disp = prox.resources.getImage("data/images/textures/purify_disp.png")
	disp:setWrap("repeat","repeat")
	self.shader:send("disp", disp)
	prox.window.setShader(self.shader)

	self:getScene():add(PurityDrone(self.leftx, self.lefty, TOTAL_TIME, OUT_TIME))
	self:getScene():add(PurityDrone(self.rightx, self.righty, TOTAL_TIME, OUT_TIME))
end

function PurityWave:update(dt, rt)
	self.shader:send("time", prox.time.getTime())
	self.shader:send("power", (1-self.speed)/(1-TARGET_SPEED))

	for i,v in ipairs(self:getScene():getEntities()) do
		if v:isInstanceOf(Slowable) then
			if v.x >= self.leftx and v.x <= self.rightx and v.y > 0 then
				v:setTimeSpeed(self.speed)
			else
				v:setTimeSpeed(1.0)
			end
		end
	end
end

function PurityWave:trigger()
	for i,v in ipairs(self:getScene():getEntities()) do
		if v:isInstanceOf(EnemyBullet) then
			if v.x >= self.leftx and v.x <= self.rightx and v.y > 0 then
				v:kill()
				self:getScene():add(Gem(v.x, v.y))
			end
		end
	end

	self:remove()
end

function PurityWave:draw()
	love.graphics.setColor(255, 255, 255, self.alpha)
	love.graphics.line(self.leftx, self.lefty-self.line_length/2, self.leftx, self.lefty+self.line_length/2)
	love.graphics.line(self.rightx, self.righty-self.line_length/2, self.rightx, self.righty+self.line_length/2)
	love.graphics.setColor(255, 255, 255, 255)
end

function PurityWave:onRemove()
	for i,v in ipairs(self:getScene():getEntities()) do
		if v:isInstanceOf(Slowable) then
			v:setTimeSpeed(1.0)
		end
	end

	prox.window.setShader()
end

return PurityWave

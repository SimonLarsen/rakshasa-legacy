local shaders = require("shaders")
local Enemy = require("game.Enemy")
local EnemyBullet = require("game.EnemyBullet")
local PurityDrone = require("game.PurityDrone")

local PurityWave = class("game.PurityWave", prox.Entity)

local TARGET_SPEED = 0.20
local TOTAL_TIME = 3.75
local IN_TIME = 0.25
local OUT_TIME = 0.5

function PurityWave:enter(x1, y1, x2, y2)
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
	self.speed = 2
	self.z = 1
	self.line_length = 0
	self.alpha = 255

	prox.timer.tween(IN_TIME, self, {speed = TARGET_SPEED}, "out-quad")
	prox.timer.tween(0.4, self, {line_length = 2*settings.screen_height}, "in-out-cubic")

	prox.timer.after(TOTAL_TIME-IN_TIME-OUT_TIME, function()
		prox.timer.tween(OUT_TIME, self, {speed = 1.0, alpha = 0}, "in-quad", function()
			self:remove()
		end)
	end)

	self.shader = shaders.getShader("data/shaders/purity.lua")
	self.shader:send("left", self.leftx)
	self.shader:send("right", self.rightx)
	self.shader:send("time", prox.time.getTime())
	local disp = prox.resources.getImage("data/images/purify_disp.png")
	disp:setWrap("repeat","repeat")
	self.shader:send("disp", disp)
	prox.window.setShader(self.shader)

	self:getScene():add(PurityDrone(self.leftx, self.lefty-28, TOTAL_TIME))
	self:getScene():add(PurityDrone(self.rightx, self.righty-28, TOTAL_TIME))
end

function PurityWave:update(dt, rt)
	self.shader:send("time", prox.time.getTime())

	for i,v in ipairs(self:getScene():getEntities()) do
		if v:isInstanceOf(Enemy) or v:isInstanceOf(EnemyBullet) then
			if v.x >= self.leftx and v.x <= self.rightx and v.y > 0 then
				v:setTimeSpeed(self.speed)
			else
				v:setTimeSpeed(1.0)
			end
		end
	end
end

function PurityWave:draw()
	love.graphics.setColor(255, 255, 255, self.alpha)
	love.graphics.line(self.leftx, self.lefty-self.line_length/2, self.leftx, self.lefty+self.line_length/2)
	love.graphics.line(self.rightx, self.righty-self.line_length/2, self.rightx, self.righty+self.line_length/2)
	love.graphics.setColor(255, 255, 255, 255)
end

function PurityWave:onRemove()
	for i,v in ipairs(self:getScene():getEntities()) do
		if v:getName() == "enemy_bullet" then
			v:setTimeSpeed(1)
		end
	end

	prox.window.setShader()
end

return PurityWave

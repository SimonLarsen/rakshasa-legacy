local shaders = require("shaders")
local Enemy = require("game.Enemy")
local EnemyBullet = require("game.EnemyBullet")
local PurityWave = class("game.PurityWave", prox.Entity)

local TARGET_SPEED = 0.20
local TOTAL_TIME = 3.75
local IN_TIME = 0.25
local OUT_TIME = 0.5

function PurityWave:enter(x1, x2)
	self.left = math.min(x1, x2)
	self.right = math.max(x1, x2)
	self.width = self.right - self.left
	self.speed = 1
	self.z = 1

	prox.timer.tween(IN_TIME, self, {speed = TARGET_SPEED}, "out-quad")
	prox.timer.after(TOTAL_TIME-IN_TIME-OUT_TIME, function()
		prox.timer.tween(OUT_TIME, self, {speed = 1.0}, "in-quad", function()
			self:remove()
		end)
	end)

	self.shader = shaders.getShader("data/shaders/purity.lua")
	self.shader:send("left", self.left)
	self.shader:send("right", self.right)
	self.shader:send("time", prox.time.getTime())
	local disp = prox.resources.getImage("data/images/purify_disp.png")
	disp:setWrap("repeat","repeat")
	self.shader:send("disp", disp)
	prox.window.setShader(self.shader)
end

function PurityWave:update(dt, rt)
	self.shader:send("time", prox.time.getTime())

	for i,v in ipairs(self:getScene():getEntities()) do
		if v:isInstanceOf(Enemy) or v:isInstanceOf(EnemyBullet) then
			if v.x >= self.left and v.x <= self.right then
				v:setTimeSpeed(self.speed)
			else
				v:setTimeSpeed(1.0)
			end
		end
	end
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

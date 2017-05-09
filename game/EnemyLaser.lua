local EnemyBullet = require("game.EnemyBullet")

local EnemyLaser = class("game.EnemyLaser", EnemyBullet)

EnemyLaser.static.STATE_BUILDUP = 1
EnemyLaser.static.STATE_PAUSE   = 2
EnemyLaser.static.STATE_SHOOT   = 3

local PAUSE_TIME = 0.04
local SHOOT_TIME = 0.15

function EnemyLaser:enter(parent, offsetx, offsety, dir, delay)
	self.parent = parent
	self.offsetx = offsetx
	self.offsety = offsety
	self.dir = dir
	self.delay = delay

	self.state = EnemyLaser.static.STATE_BUILDUP
	self.time = 0
	self.hc_shape = nil
end

function EnemyLaser:update(dt, rt)
	self.x = self.parent.x + self.offsetx
	self.y = self.parent.y + self.offsety

	self.time = self.time + dt
	if self.state == EnemyLaser.static.STATE_BUILDUP then
		if self.time >= self.delay then
			self.state = EnemyLaser.static.STATE_PAUSE
			self.time = 0
		end
	elseif self.state == EnemyLaser.static.STATE_PAUSE then
		if self.time >= PAUSE_TIME then
			self.state = EnemyLaser.static.STATE_SHOOT
			self.time = 0
			self:getScene():find("screenshaker"):shake(0.3, 1, 60)
		end
	elseif self.state == EnemyLaser.static.STATE_SHOOT then
		if self.time >= SHOOT_TIME then
			self:remove()
		end
	end
end

function EnemyLaser:draw()
	if self.state == EnemyLaser.static.STATE_BUILDUP then
		love.graphics.setColor(211, 80, 80, 255)
		love.graphics.setLineWidth(1)
		love.graphics.line(self.x, self.y, self.x+math.cos(self.dir)*500, self.y+math.sin(self.dir)*500)
		local roff = (self.delay - self.time) / self.delay * 0.4
		love.graphics.line(self.x, self.y, self.x+math.cos(self.dir+roff)*500, self.y+math.sin(self.dir+roff)*500)
		love.graphics.line(self.x, self.y, self.x+math.cos(self.dir-roff)*500, self.y+math.sin(self.dir-roff)*500)
		love.graphics.setColor(255, 255, 255, 255)

	elseif self.state == EnemyLaser.static.STATE_PAUSE then
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.setLineWidth(12)
		love.graphics.line(self.x, self.y, self.x+math.cos(self.dir)*500, self.y+math.sin(self.dir)*500)
		love.graphics.setColor(0, 0, 0, 255)
		love.graphics.setLineWidth(8)
		love.graphics.line(self.x, self.y, self.x+math.cos(self.dir)*500, self.y+math.sin(self.dir)*500)
		love.graphics.setColor(255, 255, 255, 255)

	elseif self.state == EnemyLaser.static.STATE_SHOOT then
		love.graphics.setColor(255, 80, 80, 255)
		local t = self.time / SHOOT_TIME
		local scale = 1 - t^3
		love.graphics.setLineWidth(12*scale)
		love.graphics.line(self.x, self.y, self.x+math.cos(self.dir)*500, self.y+math.sin(self.dir)*500)
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.setLineWidth(8*scale)
		love.graphics.line(self.x, self.y, self.x+math.cos(self.dir)*500, self.y+math.sin(self.dir)*500)
	end
end

function EnemyLaser:getHCShape()
	return self.hc_shape
end

return EnemyLaser

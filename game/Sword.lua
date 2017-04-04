local EnemyBullet = require("game.EnemyBullet")
local Enemy = require("game.Enemy")

local Sword = class("game.Sword", prox.Entity)

local ENTER_TIME = 0.05
local IDLE_TIME = 0.2
local DAMAGE = 15

function Sword:enter(x, y, dir, width)
	self:setName("player_sword")
	self.x = x
	self.y = y
	self.z = -1
	self.dir = dir
	self.width = 44
	self.length = 150

	self:setRenderer(prox.Animation("data/animations/sword.lua"))
	self:getRenderer():setRotation(self.dir+math.pi/2)

	self.hc_shape = HC.polygon(
		0, self.width,
		self.length, self.width,
		self.length+self.width, 0,
		self.length, -self.width,
		0, -self.width
	)
	local offx = math.cos(self.dir) * (self.length+22) / 2
	local offy = math.sin(self.dir) * (self.length+22) / 2

	self.hc_shape:moveTo(self.x + offx, self.y + offy)
	self.hc_shape:setRotation(self.dir)

	prox.timer.after(0.15, function() self:trigger() end)
end

function Sword:update(dt, rt)
	if self:getRenderer():isFinished() then
		self:remove()
	end
end

function Sword:trigger()
	self:getScene():find("screenshaker"):shake(0.2, 5, 60)

	for i,v in ipairs(self:getScene():findAll(EnemyBullet)) do
		if v:getHCShape() and self.hc_shape:collidesWith(v:getHCShape()) then
			v:kill()
		end
	end

	for i,v in ipairs(self:getScene():findAll(Enemy)) do
		local c = v:getCollider()
		if c and c:isInstanceOf(prox.BoxCollider) then
			local shape = HC.rectangle(c:getOffsetX(), c:getOffsetY(), c:getWidth(), c:getHeight())
			shape:moveTo(v.x, v.y)
			if self.hc_shape:collidesWith(shape) then
				v:onCollide(self, 0, 0)
			end
		end
	end
end

function Sword:getDamage()
	return DAMAGE
end

return Sword

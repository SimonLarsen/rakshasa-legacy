local shaders = require("shaders")
local Bullet = require("game.Bullet")
local Flash = require("game.Flash")

local DurgaShield = class("game.DurgaShield", prox.Entity)

DurgaShield.static.SIDE_LEFT  = 1
DurgaShield.static.SIDE_RIGHT = 2

function DurgaShield:enter(side)
	self.side = side
	self.hit = 0
	self.hitzone_offset = 12
	self.vulnerable = false

	if self.side == DurgaShield.static.SIDE_LEFT then
		self:setRenderer(prox.Animator("data/animators/durga_shield_left.lua"))
		self.offset_scale = -1
		self:setCollider(prox.BoxCollider(66, 26, 8, 12))
	else
		self:setRenderer(prox.Animator("data/animators/durga_shield_right.lua"))
		self.offset_scale = 1
		self:setCollider(prox.BoxCollider(66, 26, -8, 12))
	end

	self.player_chain = self:getScene():find("chain")
	self.white_shader = shaders.getShader("data/shaders/whiteout.lua")
end

function DurgaShield:update(dt, rt)
	self.hit = self.hit - dt
	self:getRenderer():setShader(self.hit > 0 and self.white_shader or nil)
end

function DurgaShield:onCollide(o, dt, rt)
	if o:getName() == "bullet" and o:isPlayerBullet() then
		if self.vulnerable then
			self.hit = 0.05
			self:damage(o:getDamage())
		end
		o:kill()
	end
end

function DurgaShield:damage(damage)
	self:getScene():find("durga"):damage(damage)
end

function DurgaShield:shootOuter()
	local gunx = self.x + self.offset_scale*35
	local guny = self.y + 32
	self:getScene():add(Bullet(gunx, guny, math.pi/2, Bullet.static.TYPE_ENEMY_BULLET))
	self:getScene():add(Flash(gunx, guny))
end

function DurgaShield:shootInner()
	local gunx = self.x - self.offset_scale*12
	local guny = self.y + 28
	local xdist = self.player_chain.x - gunx
	local ydist = self.player_chain.y - guny
	local dir = math.atan2(ydist, xdist)
	self:getScene():add(Bullet(gunx, guny, dir, Bullet.static.TYPE_ENEMY_BULLET))
	self:getScene():add(Flash(gunx, guny))
end

function DurgaShield:setVulnerable(vulnerable)
	self.vulnerable = vulnerable
	self:getRenderer():setProperty("vulnerable", self.vulnerable and 1 or 0)
end

return DurgaShield

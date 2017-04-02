local EnemyBullet = require("game.EnemyBullet")
local Flash = require("game.Flash")

local DurgaShield = class("game.DurgaShield", prox.Entity)

DurgaShield.static.SIDE_LEFT  = 1
DurgaShield.static.SIDE_RIGHT = 2

function DurgaShield:enter(side)
	self.side = side
	self.hit = 0
	self.hitzone_offset = 12
	self.vulnerable = false
	self.invulnerable = 0

	if self.side == DurgaShield.static.SIDE_LEFT then
		self:setRenderer(prox.Animator("data/animators/bosses/durga_shield_left.lua"))
		self.offset_scale = -1
		self:setCollider(prox.BoxCollider(66, 26, 8, 12))
	else
		self:setRenderer(prox.Animator("data/animators/bosses/durga_shield_right.lua"))
		self.offset_scale = 1
		self:setCollider(prox.BoxCollider(66, 26, -8, 12))
	end

	self.player_chain = self:getScene():find("chain")
	self.white_shader = prox.resources.getShader("data/shaders/whiteout.glsl")
end

function DurgaShield:update(dt, rt)
	self.hit = self.hit - dt
	self.invulnerable = self.invulnerable - dt

	self:getRenderer():setShader(self.hit > 0 and self.white_shader or nil)
end

function DurgaShield:onCollide(o, dt, rt)
	if o:getName() == "player_bullet" then
		if self.vulnerable and self.invulnerable <= 0 then
			self:damage(o:getDamage())
			self.hit = 0.05
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
	self:getScene():add(EnemyBullet(gunx, guny, math.pi/2, EnemyBullet.static.TYPE_LASER))
	self:getScene():add(Flash(gunx, guny))
end

function DurgaShield:shootInner()
	local gunx = self.x - self.offset_scale*12
	local guny = self.y + 28
	local xdist = self.player_chain.x - gunx
	local ydist = self.player_chain.y - guny
	local dir = math.atan2(ydist, xdist)
	self:getScene():add(EnemyBullet(gunx, guny, dir, EnemyBullet.static.TYPE_BALL))
	self:getScene():add(Flash(gunx, guny))
end

function DurgaShield:setVulnerable(vulnerable)
	self.vulnerable = vulnerable
	self:getRenderer():setProperty("vulnerable", self.vulnerable and 1 or 0)
end

return DurgaShield

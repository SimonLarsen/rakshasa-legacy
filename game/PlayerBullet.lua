local Explosion = require("game.Explosion")

local PlayerBullet = class("game.PlayerBullet", prox.Entity)

PlayerBullet.static.TYPE_NORMAL = 1
PlayerBullet.static.TYPE_SUPER  = 2
PlayerBullet.static.TYPE_ULTRA  = 3

local SPEED = 500

local DAMAGE = 1

function PlayerBullet:enter(x, y, dir, type)
	self:setName("player_bullet")
	self.x = x
	self.y = y
	self.z = -1
	self.dir = dir or 1.5*math.pi
	self.type = type

	self:setRenderer(prox.Sprite("data/images/bullets/player2.png", 8, 7))
	self:setCollider(prox.BoxCollider(4, 4))
	self:getRenderer():setRotation(self.dir)
end

function PlayerBullet:update(dt, rt)
	self.x = self.x + math.cos(self.dir) * SPEED * dt
	self.y = self.y + math.sin(self.dir) * SPEED * dt

	if self.x < -16 or self.x > settings.screen_width+16
	or self.y < -16 or self.y > settings.screen_height+16 then
		self:remove()
	end
end

function PlayerBullet:getDamage()
	return DAMAGE
end

function PlayerBullet:kill()
	self:getScene():add(Explosion(self.x, self.y, Explosion.static.SIZE_SMALL))
	self:remove()
end

return PlayerBullet

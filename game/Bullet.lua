local Bullet = class("game.Bullet", prox.Entity)

Bullet.static.OWNER_PLAYER = 1
Bullet.static.OWNER_ENEMY  = 2

local bullet_colors = {
	[Bullet.static.OWNER_PLAYER] = {175, 255, 223},
	[Bullet.static.OWNER_ENEMY]  = {255, 178, 178},
}

local MOVE_SPEED = 500

function Bullet:enter(x, y, owner)
	self.x = x
	self.y = y
	self.owner = owner

	if self.owner == Bullet.static.OWNER_PLAYER then
		self.yspeed = -MOVE_SPEED
		self:setRenderer(prox.Sprite("data/images/bullet_player.png", 2, 5))
	else
		self.yspeed = MOVE_SPEED
	end
end

function Bullet:update(dt, rt)
	self.y = self.y + self.yspeed * dt

	if self.y < -16 or self.y > prox.window.getHeight()+16 then
		self:remove()
	end
end

return Bullet

local BaseMine = require("game.enemies.BaseMine")
local EnemyBullet = require("game.EnemyBullet")

local Mine = class("game.enemies.Mine", BaseMine)

function Mine:enter(properties)
	BaseMine.enter(self, properties)

	self:setRenderer(prox.Animator("data/animators/enemies/mine_orthogonal.lua"))
	self:setCollider(prox.BoxCollider(28, 28))
end

function Mine:shoot()
	for i=0,3 do
		self:getScene():add(EnemyBullet(self.x, self.y, i*math.pi/2, EnemyBullet.static.TYPE_LASER))
	end
end

return Mine

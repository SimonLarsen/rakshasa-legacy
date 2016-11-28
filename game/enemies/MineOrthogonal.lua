local Mine = require("game.enemies.Mine")
local EnemyBullet = require("game.EnemyBullet")

local MineOrthogonal = class("game.enemies.MineOrthogonal", Mine)

function MineOrthogonal:enter(properties)
	Mine.enter(self, properties)

	self:setRenderer(prox.Animator("data/animators/enemies/mine_orthogonal.lua"))
	self:setCollider(prox.BoxCollider(28, 28))
end

function MineOrthogonal:shoot()
	for i=0,3 do
		self:getScene():add(EnemyBullet(self.x, self.y, i*math.pi/2, EnemyBullet.static.TYPE_LASER))
	end
end

return MineOrthogonal

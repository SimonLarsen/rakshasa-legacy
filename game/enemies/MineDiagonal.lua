local Mine = require("game.enemies.Mine")
local EnemyBullet = require("game.EnemyBullet")

local MineDiagonal = class("game.enemies.MineDiagonal", Mine)

function MineDiagonal:enter(properties)
	Mine.enter(self, properties)

	self:setRenderer(prox.Animator("data/animators/enemies/mine_diagonal.lua"))
	self:setCollider(prox.BoxCollider(28, 28))
end

function MineDiagonal:shoot()
	for i=0,3 do
		self:getScene():add(EnemyBullet(self.x, self.y, (i+0.5)*math.pi/2, EnemyBullet.static.TYPE_LASER))
	end
end

return MineDiagonal

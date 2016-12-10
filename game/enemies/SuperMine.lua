local BaseMine = require("game.enemies.BaseMine")
local EnemyBullet = require("game.EnemyBullet")

local SuperMine = class("game.enemies.SuperMine", BaseMine)

function SuperMine:enter(properties)
	BaseMine.enter(self, properties)

	self:setRenderer(prox.Animator("data/animators/enemies/mine_diagonal.lua"))
	self:setCollider(prox.BoxCollider(28, 28))
end

function SuperMine:shoot()
	for i=0,7 do
		self:getScene():add(EnemyBullet(self.x, self.y, i*math.pi/4-0.04, EnemyBullet.static.TYPE_LASER))
		self:getScene():add(EnemyBullet(self.x, self.y, i*math.pi/4, EnemyBullet.static.TYPE_LASER))
		self:getScene():add(EnemyBullet(self.x, self.y, i*math.pi/4+0.04, EnemyBullet.static.TYPE_LASER))
	end
end

return SuperMine

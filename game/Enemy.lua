local Explosion = require("game.Explosion")
local Gem = require("game.Gem")
local Slowable = require("game.Slowable")

local Enemy = class("game.Enemy", Slowable)

local MAX_HEALTH = prox.serialize.read("data/tables/max_health.lua")
local GEM_COUNTS = prox.serialize.read("data/tables/gem_counts.lua")

function Enemy:enter(large)
	Slowable.enter(self)
	self.max_health = MAX_HEALTH[self.class.name]
	self.health = self.max_health
	self.hit = 0
	self.large = large or false
	self.invulnerable = 0

	self.white_shader = prox.resources.getShader("data/shaders/whiteout.glsl")

	self.sfx_explosion1 = prox.resources.getSound("data/sounds/explosion1.wav")
	self.sfx_explosion3 = prox.resources.getSound("data/sounds/explosion3.wav")
end

function Enemy:update(dt, rt)
	dt, rt = Slowable.update(self, dt, rt)
	self.invulnerable = self.invulnerable - dt
	self.hit = self.hit - dt
	self:getRenderer():setShader(self.hit > 0 and self.white_shader or nil)
	return dt, rt
end

function Enemy:onCollide(o, dt, rt)
	if o:getName() == "player_bullet" then
		if self.invulnerable <= 0 then
			self:damage(o:getDamage())
		end
		o:kill()

		if self.health <= 0 then
			self:kill()
		end

	elseif o:getName() == "player_sword" then
		if self.invulnerable <= 0 then
			self:damage(o:getDamage())
		end

		if self.health <= 0 then
			self:kill()
		end
	end

end

function Enemy:damage(damage)
	self.health = self.health - damage
	self.hit = 0.05
end

function Enemy:kill()
	if self.large then
		self:getScene():add(Explosion(self.x, self.y, Explosion.static.SIZE_LARGE))
		self:getScene():find("screenshaker"):shake(0.5, 2, 60)
		local sfx = prox.resources.getSound("data/sounds/explosion3.wav")
		self.sfx_explosion3:play()
	else
		self:getScene():add(Explosion(self.x, self.y, Explosion.static.SIZE_MEDIUM))
		self:getScene():find("screenshaker"):shake(0.3, 1, 60)
		self.sfx_explosion1:play()
	end
	
	local num_gems = self:getGems()
	local spread = math.log(math.max(15, num_gems)) * 30
	for i=1, num_gems do
		self:getScene():add(Gem(self.x, self.y, spread))
	end

	self:remove()
end

function Enemy:getGems()
	return GEM_COUNTS[self.class.name]
end

return Enemy

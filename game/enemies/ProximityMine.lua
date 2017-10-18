local Enemy = require("game.Enemy")
local EnemyBulletExplosion = require("game.EnemyBulletExplosion")

local ProximityMine = class("game.enemies.ProximityMine", Enemy)

local MOVE_SPEED = 45
local DETONATION_DELAY = 1

function ProximityMine:enter(properties)
	Enemy.enter(self)

	self.x = properties.x
	self.radius = properties.radius
	self.y = -self.radius - 4
	self.speed = properties.speed or MOVE_SPEED
	self.detonation_delay = properties.detonation_delay or DETONATION_DELAY
	self.triggered = false
	self.detonation = 0

	self.line_width = 1
	self.player_chain = self:getScene():find("chain")

	self:setRenderer(prox.Animator("data/animators/enemies/proximity_mine.lua"))
	self:setCollider(prox.BoxCollider(28, 28))

	self.white_shader = prox.resources.getShader("data/shaders/whiteout.glsl")

	self.prox_rect = HC.circle(0, 0, self.radius)
end

function ProximityMine:update(dt, rt)
	dt, rt = Enemy.update(self, dt, rt)

	self.y = self.y + self.speed*dt
	
	self.line_width = math.cos(prox.time.getTime()*12)/2 + 1.5

	if not self.triggered then
		self.prox_rect:moveTo(self.x, self.y)
		if self.prox_rect:collidesWith(self.player_chain:getHCShape()) then
			self.triggered = true
		end
	end

	if self.triggered then
		if self.detonation_delay < 0.2 then
			self:getRenderer():setProperty("detonate", true)
		end
		self:getRenderer():setShader(prox.time.getTime() % 0.2 < 0.1 and self.white_shader or nil)
		self.detonation_delay = self.detonation_delay - dt
		if self.detonation_delay <= 0 then
			self:getScene():add(EnemyBulletExplosion(self.x, self.y, self.radius))
			self:getScene():find("screenshaker"):shake(0.4, 2, 60)
			self:remove()
		end
	end

	if self.y > prox.window.getHeight() + self.radius + 4 then
		self:remove()
	end
end

function ProximityMine:draw()
	love.graphics.setLineWidth(self.line_width)
	love.graphics.setColor(211, 80, 80)
	love.graphics.circle("line", self.x, math.floor(self.y+0.5), self.radius, 64)
	love.graphics.setColor(255, 255, 255)
	love.graphics.setLineWidth(1)
end

function ProximityMine:getGems()
	return 3
end

return ProximityMine

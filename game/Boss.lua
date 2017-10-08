local Enemy = require("game.Enemy")
local EnemyBullet = require("game.EnemyBullet")
local Gem = require("game.Gem")
local WhiteFlash = require("game.WhiteFlash")
local music = require("music")

local Boss = class("game.Boss", Enemy)

local HEALTHBAR_COOLDOWN = 0.2

function Boss:enter(boss_id, health)
	Enemy.enter(self, health, true)

	self.boss_id = boss_id
	self.healthbar = self.health
	self.healthbar_cooldown = 0
	self.active = false
	self.invulnerable = 0

	self.boss_healthbar = prox.resources.getImage("data/images/boss_healthbar.png")
end

function Boss:update(dt, rt)
	Enemy.update(self, dt, rt)

	self.invulnerable = self.invulnerable - dt

	if self.healthbar_cooldown <= 0 then
		self.healthbar = prox.math.movetowards(self.healthbar, self.health, 150*dt)
	end
	self.healthbar_cooldown = self.healthbar_cooldown - dt
end

function Boss:onCollide(o, dt, rt)
	if o:getName() == "player_bullet" then
		if self.invulnerable <= 0 then
			self:damage(o:getDamage())
		end
		o:kill()
	end
end

function Boss:damage(damage)
	if not self.active then return end

	self.hit = 0.05
	self.health = math.max(self.health - damage, 0)
	if self.health > 0 then
		self.healthbar_cooldown = HEALTHBAR_COOLDOWN
	end
	if self.health == 0 then
		self:kill()
	end
end

function Boss:kill()
	for i,v in ipairs(self:getScene():findAll(EnemyBullet)) do
		v:kill()
	end
end

function Boss:purge()
	music.stop()
	local sfx = prox.resources.getSound("data/sounds/explosion2.wav")
	sfx:play()
	self:getScene():add(WhiteFlash(1, "in-linear"))
	self:dropGems()
	self:remove()
end

function Boss:dropGems()
	local gems = self:getGems()
	local radius = 32
	for i=0, gems-1 do
		local angle = i / gems * 2*math.pi
		local x = self.x + math.cos(angle) * radius
		local y = self.y + math.sin(angle) * radius
		self:getScene():add(Gem(x, y))
	end
end

function Boss:gui()
	if not self.active then return end

	local midx = prox.window.getWidth()/2

	-- Health bar
	local bar_width = math.max(0, math.ceil(self.healthbar / self.max_health * 150))
	love.graphics.draw(self.boss_healthbar, midx, 26, 0, 1, 1, 95, 18)

	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle("fill", midx-76, 13, bar_width+2, 27)

	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle("fill", midx-75, 14, bar_width, 25)

	love.graphics.setColor(211, 80, 80)
	local bar_width = math.max(0, math.ceil(self.health / self.max_health * 150))
	love.graphics.rectangle("fill", midx-75, 14, bar_width, 25)

	love.graphics.setColor(255, 255, 255)
end

return Boss

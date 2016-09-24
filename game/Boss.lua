local Enemy = require("game.Enemy")

local Boss = class("game.Boss", Enemy)

local HEALTHBAR_COOLDOWN = 0.3

function Boss:enter(boss_id, health)
	Enemy.enter(self, health, true)

	self.boss_id = boss_id
	self.healthbar = self.health
	self.healthbar_cooldown = 0
	self.active = false

	self.boss_healthbar = prox.resources.getImage("data/images/boss_healthbar.png")
	self.name_text = prox.resources.getImage("data/images/bosstext_" .. self.boss_id .. ".png")
end

function Boss:update(dt, rt)
	Enemy.update(self, dt, rt)

	self.healthbar_cooldown = self.healthbar_cooldown - dt
	if self.healthbar_cooldown <= 0 then
		self.healthbar = prox.math.movetowards(self.healthbar, self.health, 150*dt)
	end
end

function Boss:onCollide(o, dt, rt)
	if o:getName() == "bullet" and o:isPlayerBullet() then
		self:damage(o:getDamage())
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

end

function Boss:gui()
	if not self.active then return end

	local midx = prox.window.getWidth()/2

	-- Boss name
	local textx = midx - math.floor(self.name_text:getWidth() / 2)
	love.graphics.draw(self.name_text, textx, 15)

	-- Health bar
	local bar_width = math.max(0, math.ceil(self.healthbar / self.max_health * 150))
	love.graphics.draw(self.boss_healthbar, midx, 52, 0, 1, 1, 95, 18)

	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle("fill", midx-76, 39, bar_width+2, 27)

	love.graphics.setColor(211, 80, 80)
	love.graphics.rectangle("fill", midx-75, 40, bar_width, 25)

	love.graphics.setColor(255, 255, 255)
	local bar_width = math.max(0, math.floor(self.health / self.max_health * 150))
	love.graphics.rectangle("fill", midx-75, 40, bar_width, 25)
end

return Boss

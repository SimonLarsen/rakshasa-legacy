local Enemy = require("game.Enemy")

local Boss = class("game.Boss", Enemy)

local HEALTHBAR_COOLDOWN = 0.5

function Boss:enter(boss_name, health)
	Enemy.enter(self, health, true)

	self.boss_name = boss_name
	self.healthbar = self.health
	self.healthbar_cooldown = 0
	self.active = false

	self.boss_healthbar = prox.resources.getImage("data/images/boss_healthbar.png")
	self.banner_font = prox.resources.getImageFont("data/fonts/banner_font.png")
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
		self.hit = 0.05
		if self.health <= 0 then
			self:kill()
		end
		o:kill()
	end
end

function Boss:damage(damage)
	self.health = self.health - damage
	if self.health > 0 then
		self.healthbar_cooldown = HEALTHBAR_COOLDOWN
	end
end

function Boss:kill()

end

function Boss:gui()
	if not self.active then return end

	local midx = prox.window.getWidth()/2

	-- Boss name
	love.graphics.setFont(self.banner_font)
	local name_width = self.banner_font:getWidth(self.boss_name)
	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle("fill", midx-name_width/2-10, 14, name_width+20, 28)

	love.graphics.setColor(255, 255, 255)
	love.graphics.line(midx-name_width/2-5, 20, midx+name_width/2+5, 20)

	love.graphics.setColor(0, 0, 0)
	love.graphics.printf(self.boss_name, midx-151, 16, 300, "center")
	love.graphics.printf(self.boss_name, midx-149, 16, 300, "center")
	love.graphics.setColor(255, 255, 255)
	love.graphics.printf(self.boss_name, midx-150, 16, 300, "center")
	
	-- Health bar
	local bar_width = math.max(0, math.floor(self.healthbar / self.max_health * 150))
	love.graphics.draw(self.boss_healthbar, midx, 52, 0, 1, 1, 106, 18)

	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle("fill", midx-76, 39, bar_width+2, 27)

	love.graphics.setColor(211, 80, 80)
	love.graphics.rectangle("fill", midx-75, 40, bar_width, 25)

	love.graphics.setColor(255, 255, 255)
	local bar_width = math.max(0, math.floor(self.health / self.max_health * 150))
	love.graphics.rectangle("fill", midx-75, 40, bar_width, 25)
end

return Boss

local music = require("music")
local Ship = require("game.Ship")
local Chain = require("game.Chain")
local Enemy = require("game.Enemy")
local BaseLaser = require("game.enemies.BaseLaser")
local EnemyBullet = require("game.EnemyBullet")
local ScreenShaker = require("game.ScreenShaker")
local EndText = require("game.EndText")
local Level = require("game.Level")
local cpml = require("cpml")

local DualController = require("controls.DualController")

local Controller = class("game.Controller", prox.Entity)

local constructors = {
	-- enemies
	--- meta types
	Spawner = require("game.enemies.Spawner"),
	--- drone types
	Scout = require("game.enemies.Scout"),
	Drone = require("game.enemies.Drone"),
	AimedDrone = require("game.enemies.AimedDrone"),
	--- fighter types
	Fighter = require("game.enemies.Fighter"),
	Viper = require("game.enemies.Viper"),
	Striker = require("game.enemies.Striker"),
	Chaser = require("game.enemies.Chaser"),
	--- patrol types
	Patrol = require("game.enemies.Patrol"),
	FanPatrol = require("game.enemies.FanPatrol"),
	--- bomber types
	Bomber = require("game.enemies.Bomber"),
	Dropship = require("game.enemies.Dropship"),
	--- mines
	Mine = require("game.enemies.Mine"),
	SuperMine = require("game.enemies.SuperMine"),
	ProximityMine = require("game.enemies.ProximityMine"),
	--- turret types
	Bunker = require("game.enemies.Bunker"),
	Turret = require("game.enemies.Turret"),
	LaserTurret = require("game.enemies.LaserTurret"),
	--- laser types
	Laser = require("game.enemies.Laser"),
	LaserSwitch = require("game.enemies.LaserSwitch"),
	LaserFan = require("game.enemies.LaserFan"),
	--- tank types
	Temple = require("game.enemies.Temple"),
	Fortress = require("game.enemies.Fortress"),
	Falcon = require("game.enemies.Falcon"),
	Vortex = require("game.enemies.Vortex"),
	--- silo types
	Silo = require("game.enemies.Silo"),
	--- bosses
	Fear = require("game.bosses.Fear")
}

local WARMUP_TIME = 2
local WAVE_PAUSE_TIME = 1
local TRANSITION_TIME = 9

local MAX_GEMS = 120
local POWER_BAR_LENGTH = 135
local POWER_BAR_OFFSET = 12

Controller.static.STATE_WARMUP     = 1
Controller.static.STATE_ACTIVE     = 2
Controller.static.STATE_TRANSITION = 3
Controller.static.STATE_GAMEOVER   = 4

local FOCUS_THRESHOLDS = {
	[1] = 10,
	[2] = 20,
	[3] = 40,
	[4] = 80
}

local levels = {
	[1] = {
		"data/levels/1-1.lua",
		"data/levels/1-2.lua",
		"data/levels/1-3.lua",
		"data/levels/1-4.lua"
	},
	[2] = {
		"data/levels/2-1.lua",
		"data/levels/2-2.lua"
	},
	[3] = {
	}
}

function Controller:enter(stage, level, binding)
	self:setName("controller")

	self.stage = stage
	self.level = level
	self:loadLevel()

	self.lives = 3
	self.score = 0
	self.score_multiplier = 1

	self.focus = 0
	self.focus_meter = 0
	self.focus_cooldown = 0
	self.gems = 0

	self.lives_display = self.lives
	self.score_display = self.score
	self.gems_display = self.gems

	self.binding = binding
	self.state = Controller.static.STATE_WARMUP
	self.time = 0
	self.warmup = WARMUP_TIME

	self.hud_alpha = 0
	prox.timer.tween(1, self, {hud_alpha = 255}, "out-quad")

	self:getScene():getCamera():setPosition(settings.screen_width/2, settings.screen_height/2)
	music.playFile("data/music/thunder.ogg")

	local ship_left = self:getScene():add(Ship(Ship.static.SIDE_LEFT))
	local ship_right = self:getScene():add(Ship(Ship.static.SIDE_RIGHT))
	local chain = self:getScene():add(Chain(ship_left, ship_right))
	self:getScene():add(DualController(binding, ship_left, ship_right, chain, settings.ship_switch))
	self:getScene():add(ScreenShaker())

	self.gameover_dialog = prox.resources.getImage("data/images/gameover_dialog.png")

	self.diamond_image = prox.resources.getImage("data/images/diamond.png")
	self.diamond_flash_image = prox.resources.getImage("data/images/diamond_flash.png")
	self.overlay_left = prox.resources.getImage("data/images/overlay_left.png")
	self.overlay_right = prox.resources.getImage("data/images/overlay_right.png")
	self.power_overlay = prox.resources.getImage("data/images/power_overlay.png")
	self.focus_meter_end = prox.resources.getImage("data/images/focus_meter_end.png")

	self.small_font = prox.resources.getImageFont("data/fonts/small.png")
	self.sans_font = prox.resources.getImageFont("data/fonts/large_sans.png")
end

function Controller:update(dt, rt)
	self.time = self.time + dt

	self.score_display = prox.math.movetowards(self.score_display, self.score, dt*800)
	self.gems_display = prox.math.movetowards(self.gems_display, self.gems, 20*dt)

	self.focus_cooldown = self.focus_cooldown - dt/2

	if self.focus_cooldown <= 0 then
		self.focus_meter = self.focus_meter - dt/3
	end
	if self.focus_meter <= 0 then
		self.focus = 0
		self.score_multiplier = 1
	end

	if self.state == Controller.static.STATE_WARMUP then
		self.warmup = self.warmup - dt
		if self.warmup <= 0 then
			self.state = Controller.static.STATE_ACTIVE
			self.time = 0
			self.warmup = WAVE_PAUSE_TIME
		end

	elseif self.state == Controller.static.STATE_ACTIVE then
		if self.wave > #self.events then
			self:getScene():add(EndText(self.stage, self.level))
			self:progressLevel()
		elseif self.wave == 0 then
			if self.time >= 0 then
				self.step = 1
				self.wave = self.wave + 1
				self.time = 0
				self.warmup = WAVE_PAUSE_TIME
			end
		elseif self.step > #self.events[self.wave] then
			if self:isWaveClear() then
				self.warmup = self.warmup - dt

				if self.warmup <= 0 then
					self.step = 1
					self.wave = self.wave + 1
					self.time = 0
					self.warmup = WAVE_PAUSE_TIME
				end
			end
		else
			if self.time >= self:currentStep().time then
				assert(constructors[self:currentStep().type], "Unknown entity type")
				local properties = self:currentStep().properties
				self:getScene():add(constructors[self:currentStep().type](properties))
				self.step = self.step + 1
				self.time = 0
			end
		end
	
	elseif self.state == Controller.static.STATE_TRANSITION then
		if self.time >= TRANSITION_TIME then
			self.state = Controller.static.STATE_ACTIVE
			self.time = 0
		end

	elseif self.state == Controller.static.STATE_GAMEOVER then
		if self.binding:wasPressed("confirm") then
			prox.timer.clear()
			self:getScene():clear()
			self:getScene():find("titlecontroller"):reset()
		end
	end
end

function Controller:currentStep()
	return self.events[self.wave][self.step]
end

function Controller:gui()
	love.graphics.setFont(self.sans_font)
	love.graphics.setColor(255, 255, 255, self.hud_alpha)
	love.graphics.draw(self.overlay_left, prox.window.getWidth()/2-320, 0)
	love.graphics.draw(self.overlay_right, prox.window.getWidth()/2+160, 0)

	love.graphics.printf(math.floor(self.score_display), prox.window.getWidth()/2+177, 96, 130, "center")

	-- draw lives
	for i=1, self.lives do
		love.graphics.draw(self.diamond_image, prox.window.getWidth()/2-290 + (i-1)*36, 83)
	end
	if self.lives_display > self.lives then
		love.graphics.setColor(255, 255, 255, (self.lives_display % 1)*255)
		love.graphics.draw(self.diamond_flash_image, prox.window.getWidth()/2-295+math.floor(self.lives_display)*36, 80)
	elseif self.lives_display < self.lives then
		love.graphics.setColor(255, 255, 255, (1 - (self.lives_display % 1))*255)
		love.graphics.draw(self.diamond_flash_image, prox.window.getWidth()/2-295+math.floor(self.lives_display)*36, 80)
	end

	-- power bar
	love.graphics.setColor(211, 80, 80)
	local power_width = math.floor(self.gems_display / MAX_GEMS * POWER_BAR_LENGTH + 0.5)
	love.graphics.rectangle("fill", prox.window.getWidth()/2-320+POWER_BAR_OFFSET, 198, power_width, 33)

	if self.gems_display >= MAX_GEMS/2 then
		local alpha = math.sqrt((-prox.time.getTime() % 1)) * 255
		love.graphics.setColor(255, 255, 255, alpha)
		love.graphics.rectangle("fill", prox.window.getWidth()/2-320+POWER_BAR_OFFSET, 198, POWER_BAR_LENGTH/2, 33)
	end

	if self.gems_display >= MAX_GEMS then
		local alpha = math.sqrt((-prox.time.getTime() % 1)) * 255
		love.graphics.setColor(255, 255, 255, alpha)
		love.graphics.rectangle("fill", prox.window.getWidth()/2-320+POWER_BAR_OFFSET+POWER_BAR_LENGTH/2, 198, POWER_BAR_LENGTH/2, 33)
	end

	love.graphics.setColor(255, 255, 255, self.hud_alpha)
	love.graphics.draw(self.power_overlay, prox.window.getWidth()/2-320, 197)

	if self.state == Controller.static.STATE_GAMEOVER then
		love.graphics.draw(self.gameover_dialog, prox.window.getWidth()/2, prox.window.getHeight()/2, 0, 1, 1, 160, 100)

		local midx = prox.window.getWidth()/2
		local midy = prox.window.getHeight()/2

		love.graphics.setFont(self.sans_font)
		love.graphics.printf("SCORE", midx-149, midy-20, 300, "center")
		love.graphics.printf(self.score, midx-149, midy, 300, "center")

		love.graphics.printf("YOUR BEST", midx-149, midy+30, 300, "center")
		love.graphics.printf(highscore.score, midx-149, midy+50, 300, "center")
	end

	-- focus bar
	love.graphics.setColor(211, 80, 80)
	local focus_bar_height = math.floor(math.max(0, self.focus_meter) * 142 + 0.5)
	love.graphics.rectangle("fill", prox.window.getWidth()-83, 230-focus_bar_height/2, 7, focus_bar_height)

	love.graphics.setColor(255, 255, 255, self.hud_alpha)
	love.graphics.draw(self.focus_meter_end, prox.window.getWidth()-83, 157)
	love.graphics.draw(self.focus_meter_end, prox.window.getWidth()-83, 303, 0, 1, -1)

	love.graphics.setColor(255, 255, 255, 255)
end

function Controller:isWaveClear()
	return self:getScene():find(Enemy) == nil
	   and self:getScene():find(BaseLaser) == nil
	   and (self.wave < #self.events or self:getScene():find(EnemyBullet) == nil)
end

function Controller:playerHit()
	if self.lives_tween then prox.timer.cancel(self.lives_tween) end
	self.lives_tween = prox.timer.tween(1, self, {lives_display = self.lives-1}, "in-quad")
	self.lives = self.lives - 1
	if self.lives == 0 then
		self:gameOver()
	end
end

function Controller:gameOver()
	self.state = Controller.static.STATE_GAMEOVER
	music.stop()
	if self.score > highscore.score then
		highscore.score = self.score
		saveHighscore()
	end
	for i,v in ipairs(self:getScene():findAll("ship")) do
		v:kill()
	end
	self:getScene():find("chain"):kill()
end

function Controller:addScore(points)
	self.score = self.score + points
end

function Controller:addGems(count)
	self.gems = math.min(self.gems + count, MAX_GEMS)
	self:addScore(count * 100)
	
	self.focus_meter = 1.0
	self.focus_cooldown = 1.0
	self.focus = self.focus + 1

	if self.score_multiplier < #FOCUS_THRESHOLDS and self.focus >= FOCUS_THRESHOLDS[self.score_multiplier] then
		self.focus = self.focus % FOCUS_THRESHOLDS[self.score_multiplier]
		self.score_multiplier = self.score_multiplier + 1
	end
end

function Controller:useGems(cost)
	if self.gems < cost then
		return false
	end

	self.gems = self.gems - cost
	self.gems_display = self.gems
	return true
end

function Controller:addLives(lives)
	if self.lives_tween then prox.timer.cancel(self.lives_tween) end
	self.lives = prox.math.cap(self.lives + lives, 0, 3)
	pÿ7rox.timer.tween(1, self, {lives_display = self.lives}, "in-quad")
end

function Controller:progressLevel()
	self.level = self.level+1
	if self.level > #levels[self.stage] then
		self.stage = self.stage+1
		self.level = 1
	end
	self:loadLevel()
	self.state = Controller.static.STATE_TRANSITION
	self.time = 0
end

function Controller:loadLevel()
	local level = Level()
	level:parse(levels[self.stage][self.level])
	self.events = level:getEvents()
	self.wave = 1
	self.step = 1
	self.time = 0
end

return Controller

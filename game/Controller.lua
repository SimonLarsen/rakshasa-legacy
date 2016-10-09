local serialize = require("prox.serialize")
local music = require("music")
local Ship = require("game.Ship")
local Chain = require("game.Chain")
local Enemy = require("game.Enemy")
local ScreenShaker = require("game.ScreenShaker")
local EndText = require("game.EndText")
local Heart = require("game.Heart")

local Controller = class("game.Controller", prox.Entity)

local constructors = {
	-- enemies
	ship = require("game.EnemyShip"),
	drone = require("game.EnemyDrone"),
	drone_spawner = require("game.DroneSpawner"),
	temple = require("game.EnemyTemple"),
	mine = require("game.EnemyMine"),
	turret = require("game.EnemyTurret"),
	-- bosses
	durga = require("game.BossDurga"),
	shiva = require("game.BossShiva"),
	agni = require("game.BossAgni")
}

local WARMUP_TIME = 3
local TRANSITION_TIME = 7
local MAX_GEMS = 30

Controller.static.STATE_WARMUP     = 1
Controller.static.STATE_ACTIVE     = 2
Controller.static.STATE_TRANSITION = 3
Controller.static.STATE_GAMEOVER   = 4

local levels = {
	"data/levels/1.lua",
	"data/levels/2.lua",
	"data/levels/3.lua"
}

function Controller:enter(level, binding)
	self:setName("controller")

	self:loadLevel(level)
	self.lives = 3
	self.lives_display = self.lives
	self.score = 0
	self.score_display = self.score
	self.gems = 0
	self.gems_display = self.gems
	self.binding = binding
	self.state = Controller.static.STATE_WARMUP
	self.time = 0

	self.hud_alpha = 0
	prox.timer.tween(1, self, {hud_alpha = 255}, "out-quad")

	self:getScene():getCamera():setPosition(settings.screen_width/2, settings.screen_height/2)
	music.playFile("data/music/thunder.ogg")

	local ship1 = self:getScene():add(Ship(Ship.static.SIDE_LEFT, self.binding))
	local ship2 = self:getScene():add(Ship(Ship.static.SIDE_RIGHT, self.binding))
	self:getScene():add(Chain(ship1, ship2))
	self:getScene():add(ScreenShaker())

	self.gameover_dialog = prox.resources.getImage("data/images/gameover_dialog.png")

	self.lives_bar = prox.resources.getImage("data/images/lives_bar.png")
	self.diamond_image = prox.resources.getImage("data/images/diamond.png")
	self.diamond_flash_image = prox.resources.getImage("data/images/diamond_flash.png")
	self.scorebox_image = prox.resources.getImage("data/images/scorebox.png")
	self.power_overlay = prox.resources.getImage("data/images/power_overlay.png")

	self.small_font = prox.resources.getImageFont("data/fonts/small.png")
	self.sans_font = prox.resources.getImageFont("data/fonts/large_sans.png")
end

function Controller:update(dt, rt)
	self.time = self.time + dt

	self.score_display = prox.math.movetowards(self.score_display, self.score, dt*800)
	self.gems_display = prox.math.movetowards(self.gems_display, self.gems, 20*dt)

	if self.state == Controller.static.STATE_WARMUP then
		if self.time >= WARMUP_TIME then
			self.state = Controller.static.STATE_ACTIVE
			self.time = 0
		end

	elseif self.state == Controller.static.STATE_ACTIVE then
		if self.wave > #self.events then
			self:getScene():add(EndText(self.level))
			self:progressLevel()
		elseif self.wave == 0 then
			if self.time >= 0 then
				self.step = 1
				self.wave = self.wave + 1
				self.time = 0
			end
		elseif self.step > #self.events[self.wave] then
			if self:getScene():find(Enemy) == nil and self:getScene():find(Heart) == nil then
				self.step = 1
				self.wave = self.wave + 1
				self.time = 0
			end
		else
			if self.time >= self:currentStep()[1] then
				local args = prox.table.sub(self:currentStep(), 3, #self:currentStep())
				self:getScene():add(constructors[self:currentStep()[2]](unpack(args)))
				self.step = self.step + 1
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

	if self.binding:wasPressed("screenshot") then
		local scn = love.graphics.newScreenshot()
		local file = scn:encode("png", "rakshasa-" .. os.date("%Y-%m-%M-%S") .. ".png")
	end
end

function Controller:currentStep()
	return self.events[self.wave][self.step]
end

function Controller:gui()
	love.graphics.setColor(255, 255, 255, self.hud_alpha)
	love.graphics.draw(self.scorebox_image, prox.window.getWidth()/2+163, 16)
	love.graphics.printf(math.floor(self.score_display), prox.window.getWidth()/2+177, 69, 130, "center")

	-- draw lives
	love.graphics.draw(self.lives_bar, prox.window.getWidth()/2-315, 16)
	for i=1, self.lives do
		love.graphics.draw(self.diamond_image, prox.window.getWidth()/2-289 + (i-1)*36, 22)
	end
	if self.lives_display > self.lives then
		love.graphics.setColor(255, 255, 255, (self.lives_display % 1)*255)
		love.graphics.draw(self.diamond_flash_image, prox.window.getWidth()/2-294+math.floor(self.lives_display)*36, 17)
	elseif self.lives_display < self.lives then
		love.graphics.setColor(255, 255, 255, (1 - (self.lives_display % 1))*255)
		love.graphics.draw(self.diamond_flash_image, prox.window.getWidth()/2-294+math.floor(self.lives_display)*36, 17)
	end

	love.graphics.setColor(255, 255, 255)
	
	-- power bar
	love.graphics.setColor(211, 80, 80)
	local power_width = math.floor(self.gems_display / MAX_GEMS * 125 + 0.5)
	love.graphics.rectangle("fill", prox.window.getWidth()/2-303, 88, power_width, 33)
	if self.gems >= MAX_GEMS then
		local alpha = math.sqrt((-prox.time.getTime() % 1)) * 255
		love.graphics.setColor(255, 255, 255, alpha)
		love.graphics.rectangle("fill", prox.window.getWidth()/2-303, 88, power_width, 33)
	end
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(self.power_overlay, prox.window.getWidth()/2-318, 80)

	if self.state == Controller.static.STATE_GAMEOVER then
		love.graphics.draw(self.gameover_dialog, prox.window.getWidth()/2, prox.window.getHeight()/2, 0, 1, 1, 160, 100)

		local midx = prox.window.getWidth()/2
		local midy = prox.window.getHeight()/2

		love.graphics.setFont(self.sans_font)
		love.graphics.printf("SCORE", midx-149, midy-20, 300, "center")
		love.graphics.printf(self.score, midx-149, midy, 300, "center")

		love.graphics.printf("YOUR BEST", midx-149, midy+30, 300, "center")
		love.graphics.printf(settings.highscore, midx-149, midy+50, 300, "center")
	end
end

function Controller:playerHit()
	if self.lives_tween then prox.timer.cancel(self.lives_tween) end
	self.lives_tween = prox.timer.tween(1, self, {lives_display = self.lives-1}, "in-quad")
	self.lives = self.lives - 1
	if self.lives == 0 then
		self.state = Controller.static.STATE_GAMEOVER
		music.stop()
		if self.score > settings.highscore then
			settings.highscore = self.score
		end
		for i,v in ipairs(self:getScene():findAll("ship")) do
			v:kill()
		end
		self:getScene():find("chain"):kill()
	end
end

function Controller:addScore(points)
	self.score = self.score + points
end

function Controller:addGems(count)
	self.gems = math.min(self.gems + count, MAX_GEMS)
	self:addScore(count * 100)
end

function Controller:useGems()
	self.gems = 0
	self.gems_display = 0
end

function Controller:addLives(lives)
	if self.lives_tween then prox.timer.cancel(self.lives_tween) end
	self.lives = prox.math.cap(self.lives + lives, 0, 3)
	prox.timer.tween(1, self, {lives_display = self.lives}, "in-quad")
end

function Controller:addHeart()
	self:addScore(1000)
	self:addLives(1)
end

function Controller:progressLevel()
	self:loadLevel(self.level + 1)
	self.state = Controller.static.STATE_TRANSITION
	self.time = 0
end

function Controller:loadLevel(level)
	self.level = level
	self.events = serialize.read(levels[self.level])
	self.wave = 1
	self.step = 1
	self.time = 0
end

function Controller:hasFullPower()
	return self.gems >= MAX_GEMS
end

return Controller

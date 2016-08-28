local serialize = require("prox.serialize")
local Ship = require("game.Ship")
local Chain = require("game.Chain")
local Enemy = require("game.Enemy")
local ScreenShaker = require("game.ScreenShaker")
local HexLife = require("game.HexLife")

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
	durga = require("game.BossDurga")
}

local WARMUP_TIME = 3

Controller.static.STATE_WARMUP   = 1
Controller.static.STATE_ACTIVE   = 2
Controller.static.STATE_GAMEOVER = 3

function Controller:enter(path)
	self:setName("controller")

	self.events = serialize.read(path)
	self.wave = 1
	self.step = 1
	self.time = 0
	self.lives = 3

	self.state = Controller.static.STATE_WARMUP

	self:getScene():getCamera():setPosition(settings.screen_width/2, settings.screen_height/2)

	local ship1 = self:getScene():add(Ship(Ship.static.SIDE_LEFT))
	local ship2 = self:getScene():add(Ship(Ship.static.SIDE_RIGHT))
	self:getScene():add(Chain(ship1, ship2))
	self:getScene():add(ScreenShaker())
	self:getScene():add(HexLife())

	self.border_image = prox.resources.getImage("data/images/border.png")
	self.gameover_dialog = prox.resources.getImage("data/images/gameover_dialog.png")

	self.small_font = prox.resources.getImageFont("data/fonts/small.png")
	self.banner_font = prox.resources.getImageFont("data/fonts/banner_font.png")
end

function Controller:update(dt, rt)
	self.time = self.time + dt

	if self.state == Controller.static.STATE_WARMUP then
		if self.time >= WARMUP_TIME then
			self.state = Controller.static.STATE_ACTIVE
			self.time = 0
		end

	elseif self.state == Controller.static.STATE_ACTIVE then
		if self.wave > #self.events then

		elseif self.wave == 0 then
			if self.time >= 0 then
				self.step = 1
				self.wave = self.wave + 1
				self.time = 0
			end
		elseif self.step > #self.events[self.wave] then
			if self:getScene():find(Enemy) == nil then
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

	else

	end
end

function Controller:currentStep()
	return self.events[self.wave][self.step]
end

function Controller:gui()
	local bx1 = (prox.window.getWidth() - settings.screen_width) / 2 - self.border_image:getWidth()
	local bx2 = (prox.window.getWidth() + settings.screen_width) / 2 + 1

	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle("fill", 0, 0, bx1, prox.window.getHeight())
	love.graphics.rectangle("fill", bx2, 0, bx1, prox.window.getHeight())

	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(self.border_image, bx1, 0, 0, 1, prox.window.getHeight())
	love.graphics.draw(self.border_image, bx2, 0, 0, 1, prox.window.getHeight())

	love.graphics.setFont(self.small_font)
	love.graphics.print("LIVES: " .. self.lives, bx2 + 16, prox.window.getHeight()-24)

	if self.state == Controller.static.STATE_GAMEOVER then
		love.graphics.draw(self.gameover_dialog, prox.window.getWidth()/2, prox.window.getHeight()/2, 0, 1, 1, 150, 100)

		love.graphics.setFont(self.banner_font)
		local text_width = self.banner_font:getWidth("Game over")
		local midx = prox.window.getWidth()/2
		local midy = prox.window.getHeight()/2

		love.graphics.setColor(255, 255, 255)
		love.graphics.line(midx-text_width/2-5, midy-86, midx+text_width/2+5, midy-86)

		love.graphics.setColor(0, 0, 0)
		love.graphics.setColor(255, 255, 255)
		love.graphics.printf("Game over", midx-150, midy-90, 300, "center")
	end
end

function Controller:playerHit()
	self.lives = self.lives - 1
	if self.lives == 0 then
		self.state = Controller.static.STATE_GAMEOVER
		for i,v in ipairs(self:getScene():findAll("ship")) do
			v:kill()
		end
	end
end

return Controller

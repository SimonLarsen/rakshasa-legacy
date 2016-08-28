local serialize = require("prox.serialize")
local Ship = require("game.Ship")
local Chain = require("game.Chain")
local Enemy = require("game.Enemy")
local ScreenShaker = require("game.ScreenShaker")
local HexLife = require("game.HexLife")

local Controller = class("game.Controller", prox.Entity)

local constructors = {
	ship = require("game.EnemyShip"),
	drone = require("game.EnemyDrone"),
	drone_spawner = require("game.DroneSpawner"),
	temple = require("game.EnemyTemple"),
	mine = require("game.EnemyMine"),
	turret = require("game.EnemyTurret")
}

function Controller:enter(path)
	self:getScene():getCamera():setPosition(settings.screen_width/2, settings.screen_height/2)

	local ship1 = self:getScene():add(Ship(settings.screen_width/2 - 40, settings.screen_height - 80, Ship.static.SIDE_LEFT))
	local ship2 = self:getScene():add(Ship(settings.screen_width/2 + 40, settings.screen_height - 80, Ship.static.SIDE_RIGHT))
	self:getScene():add(Chain(ship1, ship2))
	self:getScene():add(ScreenShaker())
	self:getScene():add(HexLife())

	self.events = serialize.read(path)
	self.wave = 1
	self.step = 1
	self.time = 0

	self.border_image = prox.resources.getImage("data/images/border.png")
end

function Controller:update(dt, rt)
	self.time = self.time + dt

	if self.wave > #self.events then

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
end

return Controller

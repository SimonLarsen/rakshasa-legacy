local serialize = require("prox.serialize")
local Ship = require("game.Ship")
local Chain = require("game.Chain")
local Enemy = require("game.Enemy")
local ScreenShaker = require("game.ScreenShaker")

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
	self:getScene():getCamera():setPosition(prox.window.getWidth()/2, prox.window.getHeight()/2)

	local ship1 = self:getScene():add(Ship(prox.window.getWidth()/2 - 40, prox.window.getHeight() - 80, Ship.static.SIDE_LEFT))
	local ship2 = self:getScene():add(Ship(prox.window.getWidth()/2 + 40, prox.window.getHeight() - 80, Ship.static.SIDE_RIGHT))
	self:getScene():add(Chain(ship1, ship2))
	self:getScene():add(ScreenShaker())

	self.events = serialize.read(path)
	self.wave = 1
	self.step = 1
	self.time = 0
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

return Controller

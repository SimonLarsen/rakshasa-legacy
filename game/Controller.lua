local serialize = require("prox.serialize")
local Ship = require("game.Ship")
local Chain = require("game.Chain")
local Enemy = require("game.Enemy")

local Controller = class("game.Controller", prox.Entity)

local constructors = {
	ship = require("game.EnemyShip"),
	drone = require("game.EnemyDrone"),
	drone_spawner = require("game.DroneSpawner"),
	temple = require("game.EnemyTemple"),
	mine = require("game.EnemyMine")
}

function Controller:enter(path)
	self:getScene():getCamera():setPosition(prox.window.getWidth()/2, prox.window.getHeight()/2)

	local ship1 = self:getScene():add(Ship(prox.window.getWidth()/2 - 40, prox.window.getHeight() - 80, Ship.static.SIDE_LEFT))
	local ship2 = self:getScene():add(Ship(prox.window.getWidth()/2 + 40, prox.window.getHeight() - 80, Ship.static.SIDE_RIGHT))
	self:getScene():add(Chain(ship1, ship2))

	self.events = serialize.read(path)
	self.wave = 1
	self.step = 1
	self.time = 0

	--[[
	prox.timer.after(1, function() self:getScene():add(EnemyShip(100, 180)) end)
	prox.timer.after(2, function() self:getScene():add(EnemyShip(220, 160)) end)
	prox.timer.after(3, function() self:getScene():add(EnemyShip(160, 140)) end)

	for i=0,4 do
		prox.timer.after(5+i*0.5, function() self:getScene():add(EnemyDrone({{60, -20}, {60, 500}})) end)
		prox.timer.after(5+i*0.5, function() self:getScene():add(EnemyDrone({{200, -20}, {200, 500}})) end)
	end

	prox.timer.after(9, function() self:getScene():add(EnemyTemple(140)) end)
	prox.timer.after(12, function() self:getScene():add(EnemyShip(60, 130)) end)
	prox.timer.after(13, function() self:getScene():add(EnemyShip(280, 130)) end)

	prox.timer.after(18, function() self:getScene():add(EnemyMine(160, 200)) end)
	prox.timer.after(19, function() self:getScene():add(EnemyMine(80, 240)) end)
	prox.timer.after(19, function() self:getScene():add(EnemyMine(240, 200)) end)
	prox.timer.after(20, function() self:getScene():add(EnemyTemple(160)) end)

	prox.timer.after(21, function() self:getScene():add(EnemyShip(40, 200)) end)
	prox.timer.after(21, function() self:getScene():add(EnemyShip(280, 200)) end)

	prox.timer.after(25, function() self:getScene():add(EnemyShip(80, 200)) end)
	prox.timer.after(25, function() self:getScene():add(EnemyShip(240, 200)) end)
	]]
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

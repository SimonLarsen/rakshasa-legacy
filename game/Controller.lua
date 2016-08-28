local Ship = require("game.Ship")
local Chain = require("game.Chain")

local EnemyShip = require("game.EnemyShip")
local EnemyDrone = require("game.EnemyDrone")
local EnemyTemple = require("game.EnemyTemple")
local EnemyMine = require("game.EnemyMine")

local Controller = class("game.Controller", prox.Entity)

function Controller:enter()
	self:getScene():getCamera():setPosition(prox.window.getWidth()/2, prox.window.getHeight()/2)

	local ship1 = self:getScene():add(Ship(prox.window.getWidth()/2 - 40, prox.window.getHeight() - 80, Ship.static.SIDE_LEFT))
	local ship2 = self:getScene():add(Ship(prox.window.getWidth()/2 + 40, prox.window.getHeight() - 80, Ship.static.SIDE_RIGHT))
	self:getScene():add(Chain(ship1, ship2))

	prox.timer.after(1, function() self:getScene():add(EnemyShip(100, 120)) end)
	prox.timer.after(2, function() self:getScene():add(EnemyShip(220, 110)) end)
	prox.timer.after(3, function() self:getScene():add(EnemyShip(160, 100)) end)

	for i=0,6 do
		prox.timer.after(5+i*0.5, function() self:getScene():add(EnemyDrone({{60, -20}, {60, 500}})) end)
		prox.timer.after(5+i*0.5, function() self:getScene():add(EnemyDrone({{200, -20}, {200, 500}})) end)
	end

	prox.timer.after(10, function() self:getScene():add(EnemyTemple(140)) end)
	prox.timer.after(13, function() self:getScene():add(EnemyShip(60, 130)) end)
	prox.timer.after(14, function() self:getScene():add(EnemyShip(280, 130)) end)
	prox.timer.after(16, function() self:getScene():add(EnemyTemple(140)) end)
end

return Controller

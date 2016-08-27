local Ship = require("game.Ship")
local Chain = require("game.Chain")

local EnemyShip = require("game.EnemyShip")

local Controller = class("game.Controller", prox.Entity)

function Controller:enter()
	self:getScene():getCamera():setPosition(prox.window.getWidth()/2, prox.window.getHeight()/2)

	local ship1 = self:getScene():add(Ship(prox.window.getWidth()/2 - 40, prox.window.getHeight() - 80, Ship.static.SIDE_LEFT))
	local ship2 = self:getScene():add(Ship(prox.window.getWidth()/2 + 40, prox.window.getHeight() - 80, Ship.static.SIDE_RIGHT))
	self:getScene():add(Chain(ship1, ship2))

	prox.timer.after(1, function() self:getScene():add(EnemyShip( 50, 80)) end)
	prox.timer.after(2, function() self:getScene():add(EnemyShip(270, 100)) end)
	prox.timer.after(4, function() self:getScene():add(EnemyShip(120, 120)) end)
	prox.timer.after(6, function() self:getScene():add(EnemyShip(200, 140)) end)

	prox.timer.after(10, function()
		self:getScene():add(EnemyShip(80, 100))
		self:getScene():add(EnemyShip(220, 100))
	end)
end

return Controller

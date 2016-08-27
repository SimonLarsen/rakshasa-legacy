local Ship = require("game.Ship")
local Chain = require("game.Chain")

local EnemyShip = require("game.EnemyShip")
local EnemyDrone = require("game.EnemyDrone")
local EnemyTemple = require("game.EnemyTemple")

local Controller = class("game.Controller", prox.Entity)

function Controller:enter()
	self:getScene():getCamera():setPosition(prox.window.getWidth()/2, prox.window.getHeight()/2)

	local ship1 = self:getScene():add(Ship(prox.window.getWidth()/2 - 40, prox.window.getHeight() - 80, Ship.static.SIDE_LEFT))
	local ship2 = self:getScene():add(Ship(prox.window.getWidth()/2 + 40, prox.window.getHeight() - 80, Ship.static.SIDE_RIGHT))
	self:getScene():add(Chain(ship1, ship2))

	self:getScene():add(EnemyTemple(160))
end

return Controller

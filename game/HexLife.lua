local Enemy = require("game.Enemy")
local Ship = require("game.Ship")
local Bullet = require("game.Bullet")
local Gem = require("game.Gem")

local HexLife = class("game.HexLife", prox.Entity)

local UPDATE_DELAY = 0.5
local SCROLL_SPEED = 20

local cell_alive = function(map, x, y)
	if x < 0 or x >= #map
	or y < 0 or y >= #map[0] then
		return 0
	end

	return map[x][y] and 1 or 0
end

function HexLife:enter()
	self:setName("hexlife")
	self.y = -28
	self.z = 10

	self.hex16 = prox.resources.getImage("data/images/hex16.png")
	self.mapw = math.floor(settings.screen_width/ 16)
	self.maph = math.floor(settings.screen_height / 14) + 2

	self.map = self:createNumericMap(self.mapw, self.maph)
end

function HexLife:update(dt, rt)
	self.y = self.y + dt * SCROLL_SPEED
	if self.y >= 0 then
		self.y = -28
		self:scrollUp()
	end

	for iy=0, self.maph-1 do
		for ix=0, self.mapw-1 do
			self.map[ix][iy] = prox.math.movetowards(self.map[ix][iy], 0, 16*self.map[ix][iy]^2*dt)
		end
	end

	for i,v in ipairs(self:getScene():getEntities()) do
		if v:isInstanceOf(Enemy) or v:isInstanceOf(Ship)
		or v:isInstanceOf(Bullet) or v:isInstanceOf(Gem) then
			self:setAtPosition(v.x, v.y, math.max(0.09, self:getAtPosition(v.x, v.y)))
		end
	end
end

function HexLife:draw()
	for iy=0, self.maph-1 do
		for ix=0, self.mapw-1 do
			if self.map[ix][iy] > 0 then
				love.graphics.setColor(255, 255, 255, 255*self.map[ix][iy])
				if iy % 2 == 0 then
					love.graphics.draw(self.hex16, ix*16-4, iy*14 + self.y)
				else
					love.graphics.draw(self.hex16, ix*16+4, iy*14 + self.y)
				end
			end
		end
	end
	love.graphics.setColor(255, 255, 255, 255)
end

function HexLife:scrollUp()
	for iy=self.maph-1,2,-1 do
		for ix=0, self.mapw-1 do
			self.map[ix][iy] = self.map[ix][iy-2]
		end
	end

	for iy = 0, 1 do
		for ix=0, self.mapw-1 do
			self.map[ix][iy] = 0
		end
	end
end

function HexLife:clearMap(map, value)
	for iy=0, self.maph-1 do
		for ix=0, self.mapw-1 do
			map[ix][iy] = value
		end
	end
end

function HexLife:updateMap()
	local new = self.map2
	local old = self.map1

	for iy=0, self.maph-1 do
		for ix=0, self.mapw-1 do
			local neighbors = 0
			neighbors = cell_alive(old, ix-1, iy) + cell_alive(old, ix+1, iy) + cell_alive(old, ix, iy-1) + cell_alive(old, ix, iy+1)
			if iy % 2 == 0 then
				neighbors = neighbors + cell_alive(old, ix-1, iy-1) + cell_alive(old, ix-1, iy+1)
			else
				neighbors = neighbors + cell_alive(old, ix+1, iy-1) + cell_alive(old, ix+1, iy+1)
			end

			-- alive
			if cell_alive(old, ix, iy) then
				new[ix][iy] = neighbors >= 3 and neighbors <= 4
			-- dead
			else
				new[ix][iy] = neighbors == 2
			end
		end
	end

	self.map1 = new
	self.map2 = old
end

function HexLife:createBooleanMap(w, h)
	local map = {}
	for ix=0,self.mapw-1 do
		map[ix] = {}
		for iy=0,self.maph-1 do
			map[ix][iy] = false
		end
	end
	return map
end

function HexLife:createNumericMap(w, h)
	local map = {}
	for ix=0,self.mapw-1 do
		map[ix] = {}
		for iy=0,self.maph-1 do
			map[ix][iy] = 0
		end
	end
	return map
end

function HexLife:setCell(x, y, value)
	if x < 0 or x >= self.mapw
	or y < 0 or y >= self.maph then
		return
	end
	self.map[x][y] = value
end

function HexLife:getCell(x, y)
	if x < 0 or x >= self.mapw
	or y < 0 or y >= self.maph then
		return 0
	end
	return self.map[x][y]
end

function HexLife:positionToCell(x, y)
	local cx, cy

	cy = math.floor((y-self.y) / 14)
	if cy % 2 == 0 then
		cx = math.floor((x - 12) / 15)
	else
		cx = math.floor((x - 4) / 15)
	end

	return cx, cy
end

function HexLife:setAtPosition(x, y, value)
	local cx, cy = self:positionToCell(x, y)
	self:setCell(cx, cy, value)
end

function HexLife:getAtPosition(x, y)
	local cx, cy = self:positionToCell(x, y)
	return self:getCell(cx, cy)
end

function HexLife:fillAll(value)
	for ix=0,self.mapw-1 do
		for iy=0,self.maph-1 do
			self.map[ix][iy] = 1
		end
	end
end

return HexLife

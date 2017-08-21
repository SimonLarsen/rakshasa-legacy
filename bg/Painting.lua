local Painting = class("bg.Painting", prox.Entity)

local DT = 1 / 40
local SCROLL_SPEED = 200

function Painting:enter()
	self:setName("painting")
	self.z = 100
	self.dt_acc = 0

	self.shader = prox.resources.getShader("data/shaders/painting.glsl")

	self.splatters = {}
	self.squares = {}

	self.pattern = love.graphics.newImage("data/images/paintings/1.png")

	self.height = self.pattern:getHeight()
	self.inner_height = self.pattern:getHeight() / 2
	self.offset = self.height/2 + self.inner_height / 2 - 240

	self.canvas  = love.graphics.newCanvas(320, self.height)
	self.canvas2 = love.graphics.newCanvas(320, self.height)
end

function Painting:addSplatter(x, y, count, no_drops)
	for i=1, count do
		local s = {
			x = x,
			y = y,
			dir = love.math.random()*math.pi*2,
			scale = 1,
			size = love.math.random(4, 24),
			turn = (love.math.random() - 0.5) * 30,
			speed = 10,
			pattern = (no_drops == true)
		}
		table.insert(self.squares, s)
	end
end

function Painting:update(dt, rt)
	self.dt_acc = self.dt_acc + dt
	self.offset = self.offset - SCROLL_SPEED*dt
	if self.offset < self.height/2 - self.inner_height/2 - 240 then
		self.offset = self.offset + self.inner_height
		love.graphics.setCanvas(self.canvas2)
		love.graphics.clear()
		love.graphics.draw(self.canvas, 0, self.height/2)
		love.graphics.setCanvas()
		self.canvas, self.canvas2 = self.canvas2, self.canvas
	end

	if self.dt_acc < DT then return end
	self.dt_acc = self.dt_acc % DT

	love.graphics.setCanvas(self.canvas)

	love.graphics.push()
	love.graphics.translate(0, self.offset)

	for i=#self.squares, 1, -1 do
		local v = self.squares[i]

		v.scale = prox.math.movetowards(v.scale, 0, dt*8)
		v.dir = v.dir + v.turn*DT
		v.x = v.x + math.cos(v.dir) * v.speed
		v.y = v.y + math.sin(v.dir) * v.speed
		local sc = v.scale * v.size

		love.graphics.push()
		love.graphics.translate(v.x, v.y)
		love.graphics.rotate(math.pi/4)

		love.graphics.setShader(v.pattern and self.shader or nil)
		love.graphics.rectangle("fill", -0.5*sc, -0.5*sc, sc, sc)
		love.graphics.setShader()

		love.graphics.pop()

		if v.scale <= 0 then
			if v.pattern then
				table.remove(self.squares, i)
			else
				v.pattern = true
				v.scale = 1
			end
		end
	end

	love.graphics.pop()
	love.graphics.setCanvas()
end

function Painting:draw()
	self.shader:send("pattern", self.pattern)
	self.shader:send("pattern_size", {self.pattern:getDimensions()})

	love.graphics.setColor(150, 28, 28, 255)
	love.graphics.draw(self.canvas, 0, -self.offset)
	love.graphics.setColor(255, 255, 255, 255)
end

function Painting:keepAlive()
	return true
end

return Painting

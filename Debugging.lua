local Debugging = class("Debugging", prox.Entity)

function Debugging:enter()
	self.z = -100

	self.font = prox.resources.getImageFont("data/fonts/small.png")
	self.on = false
end

function Debugging:draw()
	if prox.keyboard.wasPressed("f1") then
		self.on = not self.on
	end

	if not self.on then return end

	love.graphics.setColor(255, 0, 0)
	for i,v in ipairs(self:getScene():getEntities()) do
		local c = v:getCollider()
		if c then
			if c:isInstanceOf(prox.BoxCollider) then
				love.graphics.rectangle("line", v.x+c:getOffsetX()-c:getWidth()/2, v.y+c:getOffsetY()-c:getHeight()/2, c:getWidth(), c:getHeight())
			end
		end
	end

	love.graphics.setColor(0, 255, 0)
	for i,v in ipairs(self:getScene():getEntities()) do
		if v.getHCShape and v:getHCShape() then
			v:getHCShape():draw("line")
		end
	end

	love.graphics.setColor(255, 255, 255)
end

local round_dec = function(x, d)
	local e = 10^d
	return math.floor(x*e + 0.5) / e
end

function Debugging:gui()
	if not self.on then return end

	love.graphics.setFont(self.font)
	love.graphics.printf("FPS: " .. math.floor(love.timer.getFPS()+0.5), prox.window.getWidth()-160, prox.window.getHeight()-16, 152, "right")

	local controller = self:getScene():find("controller")
	if not controller then return end

	love.graphics.printf(string.format("ENTITIES: %d", #self:getScene():getEntities()), prox.window.getWidth()-160, prox.window.getHeight()-80, 152, "right")
	love.graphics.printf(string.format("LEVEL: %d", controller.level), prox.window.getWidth()-160, prox.window.getHeight()-64, 152, "right")
	love.graphics.printf(string.format("WAVE: %d", controller.wave), prox.window.getWidth()-160, prox.window.getHeight()-48, 152, "right")
	love.graphics.printf(string.format("WARMUP: %.2f", controller.warmup), prox.window.getWidth()-160, prox.window.getHeight()-32, 152, "right")
end

return Debugging

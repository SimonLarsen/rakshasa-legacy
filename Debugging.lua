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

function Debugging:gui()
	if not self.on then return end

	love.graphics.setFont(self.font)
	love.graphics.printf("FPS: " .. math.floor(love.timer.getFPS()+0.5), prox.window.getWidth()-100, prox.window.getHeight()-16, 90, "right")
end

return Debugging

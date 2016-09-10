local OptionsMenu = class("title.OptionsMenu", prox.Entity)

local fullscreen_modes = {
	"scale", "fill", "stretch"
}

local bool_to_onoff = function(x)
	return x and "ON" or "OFF"
end

local options = {
	{
		label = "FULLSCREEN",
		action=function()
			prox.window.toggleFullscreen()
		end,
		value=function()
			return bool_to_onoff(prox.window.getFullscreen())
		end
	},
	{
		label = "FS MODE",
		action=function()
			prox.window.toggleFullscreenMode()
		end,
		value=function()
			return prox.window.getFullscreenMode():upper()
		end
	},
	{
		label = "SCALE",
		action=function() end,
		value=function()
			return prox.window.getScale()
		end
	},
	{
		label = "BACK",
		action=function(o)
			o:hide()
			o:getScene():find("titlecontroller"):reset()
		end
	},
}

function OptionsMenu:enter(binding)
	self:setName("optionsmenu")

	self.binding = binding
	self.selection = 1
	self.ready = false
	self.alpha = 0
	prox.timer.tween(1, self, {alpha = 255}, "out-cubic", function() self.ready = true end)

	self.sans_font = prox.resources.getImageFont("data/fonts/large_sans.png")
end

function OptionsMenu:update(dt, rt)
	if self.ready then
		if self.binding:wasPressed("down") then
			self.selection = prox.math.wrap(self.selection + 1, 1, #options)
		elseif self.binding:wasPressed("up") then
			self.selection = prox.math.wrap(self.selection - 1, 1, #options)
		end

		if self.binding:wasPressed("confirm") then
			options[self.selection].action(self)
			self.ready = false
			prox.timer.after(0.5, function() self.ready = true end)
		end
	end
end

function OptionsMenu:gui()
	love.graphics.setColor(255, 255, 255, self.alpha)
	love.graphics.setFont(self.sans_font)

	local midx = prox.window.getWidth()/2
	local centerx = prox.window.getWidth()/2 + 30

	for i,v in ipairs(options) do
		love.graphics.printf(v.label, centerx-310, 260+(i-1)*30, 300, "right")
		local value
		if v.value then
			if type(v.value) == "function" then
				value = v.value()
			else
				value = v.value
			end
		end
		if value then
			love.graphics.printf(v.value(), centerx+10, 260+(i-1)*30, 300, "left")
		end

		if self.ready and self.selection == i then
			local leftx = centerx - self.sans_font:getWidth(v.label) - 24
			local rightx = centerx + 24
			if value then
				rightx = centerx + self.sans_font:getWidth(v.value()) + 24
			end

			love.graphics.line(midx-150, 268+(i-1)*30, leftx, 268+(i-1)*30)
			love.graphics.line(rightx, 268+(i-1)*30, midx+150, 268+(i-1)*30)
		end
	end

	love.graphics.setColor(255, 255, 255, 255)
end

function OptionsMenu:hide()
	self.ready = false
	prox.timer.tween(1, self, {alpha = 0}, "out-quad", function() self:remove() end)
end

return OptionsMenu

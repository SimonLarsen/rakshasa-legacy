local OptionsMenu = class("title.OptionsMenu", prox.Entity)

local fullscreen_modes = {
	"scale", "fill", "stretch"
}

local fullscreen_mode_id = {
	["scale"] = 1,
	["fill"] = 2,
	["stretch"] = 3
}

local bool_to_onoff = function(x)
	return x and "ON" or "OFF"
end

local toggle_fullscreen = function()
	prox.window.toggleFullscreen()
	return true
end

local toggle_auto_switch = function()
	settings.ship_switch = not settings.ship_switch
	return true
end

local prev_fs_mode = function()
	local id = fullscreen_mode_id[prox.window.getFullscreenMode()]
	local mode = fullscreen_modes[prox.math.wrap(id-1, 1, #fullscreen_modes)]
	prox.window.setFullscreenMode(mode)
	return true
end

local next_fs_mode = function()
	local id = fullscreen_mode_id[prox.window.getFullscreenMode()]
	local mode = fullscreen_modes[prox.math.wrap(id+1, 1, #fullscreen_modes)]
	prox.window.setFullscreenMode(mode)
	return true
end

local options = {
	{
		label = "FULLSCREEN",
		action=toggle_fullscreen,
		right=toggle_fullscreen,
		left=toggle_fullscreen,
		value=function()
			return bool_to_onoff(prox.window.getFullscreen())
		end
	},
	{
		label = "FS MODE",
		action=next_fs_mode,
		left=prev_fs_mode,
		right=next_fs_mode,
		value=function()
			return prox.window.getFullscreenMode():upper()
		end
	},
	{
		label = "SCALE",
		left=function()
			local sc = prox.window.getScale()
			prox.window.setScale(math.max(1, sc-1))
		end,
		right=function()
			local sc = prox.window.getScale()
			prox.window.setScale(sc+1)
		end,
		value=function()
			return prox.window.getScale()
		end
	},
	{
		label = "AUTO SWITCH",
		action=toggle_auto_switch,
		right=toggle_auto_switch,
		left=toggle_auto_switch,
		value=function()
			return bool_to_onoff(settings.ship_switch)
		end
	},
	{
		label = "BACK",
		action=function(o)
			o:hide()
			o:getScene():find("titlecontroller"):reset(true)
			o.sfx_confirm:play()
			o:saveSettings()
			return false
		end
	},
}

function OptionsMenu:enter(binding)
	self:setName("optionsmenu")

	self.binding = binding
	self.selection = 1
	self.ready = false
	self.alpha = 0
	prox.timer.after(1, function()
		prox.timer.tween(1.8, self, {alpha = 255 + #options*80}, "out-quad")
	end)

	prox.timer.after(2.0, function() self.ready = true end)
	self.sans_font = prox.resources.getImageFont("data/fonts/large_sans.png")

	self.sfx_blip = prox.resources.getSound("data/sounds/blip.wav")
	self.sfx_confirm = prox.resources.getSound("data/sounds/weird_bang.wav")
end

function OptionsMenu:update(dt, rt)
	if self.ready then
		if self.binding:wasPressed("down") then
			self.selection = prox.math.wrap(self.selection + 1, 1, #options)
			self.sfx_blip:play()
		elseif self.binding:wasPressed("up") then
			self.selection = prox.math.wrap(self.selection - 1, 1, #options)
			self.sfx_blip:play()
		elseif self.binding:wasPressed("left") then
			if options[self.selection].left then
				options[self.selection].left(self)
				prox.timer.after(0.2, function() self.ready = true end)
				self.ready = false
				self.sfx_blip:play()
			end
		elseif self.binding:wasPressed("right") then
			if options[self.selection].right then
				options[self.selection].right(self)
				prox.timer.after(0.2, function() self.ready = true end)
				self.ready = false
				self.sfx_blip:play()
			end
		elseif self.binding:wasPressed("confirm") then
			if options[self.selection].action then
				if options[self.selection].action(self) then
					prox.timer.after(0.2, function() self.ready = true end)
				end
				self.ready = false
			end
		end
	end
end

function OptionsMenu:gui()
	love.graphics.setFont(self.sans_font)

	local midx = prox.window.getWidth()/2
	local centerx = prox.window.getWidth()/2 + 30
	local top = 200

	for i,v in ipairs(options) do
		local alpha = prox.math.cap(self.alpha-math.abs(i-self.selection)*80, 0, 255)
		love.graphics.setColor(255, 255, 255, alpha)

		love.graphics.printf(v.label, centerx-310, top+(i-1)*30, 300, "right")
		local value
		if v.value then
			if type(v.value) == "function" then
				value = v.value()
			else
				value = v.value
			end
		end
		if value then
			love.graphics.printf(v.value(), centerx+10, top+(i-1)*30, 300, "left")
		end

		if self.ready and self.selection == i then
			local leftx = centerx - self.sans_font:getWidth(v.label) - 24
			local rightx = centerx + 24
			if value then
				rightx = centerx + self.sans_font:getWidth(v.value()) + 24
			end

			love.graphics.line(midx-150, top+8+(i-1)*30, leftx, top+8+(i-1)*30)
			love.graphics.line(rightx, top+8+(i-1)*30, midx+150, top+8+(i-1)*30)
		end
	end

	love.graphics.setColor(255, 255, 255, 255)
end

function OptionsMenu:saveSettings()
	settings.scale = prox.window.getScale()
	settings.fullscreen = prox.window.getFullscreen()
	settings.fullscreen_mode = prox.window.getFullscreenMode()
	saveSettings()
end

function OptionsMenu:hide()
	self.ready = false
	prox.timer.tween(1.8, self, {alpha = 0}, "out-quad", function() self:remove() end)
end

return OptionsMenu

local music = {}

local instance = nil
local volume = 1

function music.playFile(path)
	if true then return end

	if current then
		current:stop()
	end

	local source = love.audio.newSource(path, "stream")
	instance = love.audio.play(source)
	instance:setVolume(volume)
	instance:setLooping(true)
end

function music.stop()
	if instance then
		instance:stop()
		instance = nil
	end
end

function music.setVolume(v)
	volume = v
	if current then
		instance:setVolume(volume)
	end
end

return music

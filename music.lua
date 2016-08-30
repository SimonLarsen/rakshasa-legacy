local current = nil

local music = {}

function music.playFile(path)
	if current then
		current:stop()
	end

	current = love.audio.newSource(path, "stream")
	love.audio.play(current)
end

function music.stop()
	if current then
		current:stop()
		current = nil
	end
end

function music.setVolume(volume)
	if current then
		current:setVolume(volume)
	end
end

return music

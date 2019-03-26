local audio = {}

-- Loads in the audio files specified in the file
-- audio.dat located in the assets folder
function audio.load()
	love.audio.setDistanceModel("none")

	local skip = false -- variable to skip the first line of tile

	-- Go through each line of the file
	for line in love.filesystem.lines("assets/audio.dat") do
		if skip then
			-- Split the string
			local split = string.gmatch(line, "%S+")

			-- Get the data from the split string
			local name = split()
			local streamType = split()
			local loops = split()
			local path = split()

			-- Generates a love audio source
			audio[name] = love.audio.newSource("assets/" .. path, streamType)

			local loopBool = (loops == "true")
			audio[name]:setLooping(loopBool)
		else
			skip = true
		end
	end
end

-- Plays the specififed audio file
function audio.play(id)
	if audio[id] ~= nil then
		love.audio.play(audio[id])
	end
end

-- Pauses all audio or the specified audio file
function audio.pause(id)
	if id == nil then
		love.audio.pause()
	elseif audio[id] ~= nil then
		love.audio.pause(audio[id])
	end
end

-- Resumes all audio or the specified audio file
function audio.resume(id)
	if id == nil then
		love.audio.resume()
	elseif audio[id] ~= nil then
		love.audio.resume(audio[id])
	end
end

-- Stops all audio or the specified audio file
function audio.stop(id)
	if id == nil then
		love.audio.stop()
	elseif audio[id] ~= nil then
		love.audio.stop(audio[id])
	end
end

return audio
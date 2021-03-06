local afterLevel = {}

local won

function afterLevel.start(didWin)
	won = didWin

	-- Clear all unneeded data
	clearAllLoadedData()
end

function afterLevel.update(dt)
	if getInputInstance().count == 2 then
		-- Return to main menu
		goToMainMenu()
	end
end

function afterLevel.render(screen)
	love.graphics.setNewFont(64)

	if won then
		love.graphics.print('You win!!', 0, 0)
	else
		love.graphics.print('You LOSE!!!', 0, 0)
	end
end

return afterLevel
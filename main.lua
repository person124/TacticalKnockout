local main = {}

-- Both of these are global objects
require("core/utils") -- This contains global public functions
require("core/ai_core") -- Contains AI functions

require("core/tiles") -- Handles all the different types of tiles
require("core/entity") -- Handles data for entity creation
--require("core/map") -- Contains data of the current tile arrangement
local game = require("core/game")

-- This is used to generate a background so the screen is not
-- Black and empty where the game isn't
local screenFiller = nil

-- Built in function called before the game starts, all data will be loaded in here
function love.load()
	main.input = require("core/input")
	main.input.load()
	
	-- Handles the subscreen and everything related to it
	main.screen = require("core/screen")
	main.screen.load()

	-- Handles texture loading and caching
	main.textures = require("core/textures")
	main.textures.load()

	tiles.load()
	entity.load()

	game.load()

	screenFiller = require("core/screenFiller")
end

-- Built in function called every frame to have updates
-- dt parameter is the step update time
function love.update(dt)
	main.input.update(game, main.screen)
end

-- Built in function called every frame to render the scene
function love.draw()
	love.graphics.draw(screenFiller)

	main.screen.start()
		game.map.render(main.screen)
	main.screen.stop()
end

function getGameInstance()
	return game
end

function getInputInstance()
	return main.input
end

function getScreenInstance()
	return main.screen
end

function getTexturesInstance()
	return main.textures
end

function getTexture(id)
	return main.textures[id]
end
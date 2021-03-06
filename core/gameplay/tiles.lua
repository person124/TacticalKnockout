local tiles = {}

local tilesDefaultFuncs = require("core/tileDefaultFunctions")

-- create a tile with the specified data
local function createTile(id, isSolid, anim, funcs)
	local tile = {}

	tile.id = id

	tile.isSolid = isSolid
	tile.anim = anim

	-- Default functions
	tile.funcs = utils.mergeFunctions(tilesDefaultFuncs, funcs)
	tile.funcs = utils.protect(tile.funcs)

	tiles.data[tile.id] = tile
	tiles.count = tiles.count + 1
end

-- Creates the table to store tiles in
function tiles.load()
	tiles.data = {}
	tiles.count = 0
end

-- This will load tile(s) from a file, if the second parameter is true
-- Than the tiles will be marked as built in ones and not deleted on refresh
function tiles.loadFile(fileName, animations)
	local loadedFile = require(fileName)

	for i=1,table.getn(loadedFile) do
		local tile = loadedFile[i]

		-- Check the tile data
		assert(tile.id ~= nil, "No ID set for " .. fileName)
		assert(tile.isSolid ~= nil, "No solidity set for " .. fileName)
		assert(tile.anim ~= nil, "No animation set for " .. fileName)

		local anim = animations[tile.anim]

		-- If it passes, then create tile
		createTile(tile.id, tile.isSolid, anim, tile.funcs)
	end
end

-- This functions clears the list of non-builtin tiles
function tiles.clear()
	tiles.data = {}
	tiles.count = 0
end

function tiles.render(tile, xPos, yPos, screen)
	-- Calculate the position of the tile including screen offsets
	local adjX = (xPos - 1) * 64
	local adjY = (yPos - 1) * 64

	adjX = adjX - screen.offset.x
	adjY = adjY - screen.offset.y

	-- If the tile has a quad then render it using it, otherwise render normally
	love.graphics.draw(getTexture(tile.anim.info.sheet),
		tile.anim:getFrame(), adjX, adjY)
end

return tiles
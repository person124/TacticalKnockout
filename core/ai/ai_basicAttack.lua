--[[
	This function will take in the map, entity that is attacking, the target,
	the movement map, and the attacking map. As a result it will attack the specified entity
	while moving the attacker to a suitable space.
--]]

local function getDistance(map, point1, point2)

end

function basicAttack(map, ent, target, moveMap)
	-- Steps:
	-- 1) Get range
	-- 2) Get movement tile at specified range
	-- 3) Move unit
	-- 4) Apply damage
	
	-- 1) range is just ent.rn
	local endPoint = getPoint(target.x, target.y)
	-- 2)
	local toUseID = 0
	local maxDistance = 0
	for i=1,table.getn(moveMap) do
		-- Go with the tile that is the farthest away
		local dist = getDistance(moveMap[i], endPoint)
		if dist <= ent.rn and dist > maxDistance then
			toUseID = i
			maxDistance = dist
		end
	end
	
	-- If no tile was selected then wut???
	if toUseID == 0 then return end
	
	-- 3)
	map.moveEntity(ent, moveMap[toUseID].x, moveMap[toUseID].y)
	
	-- 4)
	target.funcs.damage(ent, target, ent.at)
end

return basicAttack
--[[
    GD50
    Super Mario Bros. Remake

    -- GameLevel Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

GameLevel = Class{}

function GameLevel:init(entities, objects, tilemap)
    self.entities = entities
    self.objects = objects
    self.tileMap = tilemap

    
end

--[[
    Remove all nil references from tables in case they've set themselves to nil.
]]
function GameLevel:clear()
    for i = #self.objects, 1, -1 do
        if not self.objects[i] or self.objects[i].shouldDelete then
            table.remove(self.objects, i)
        end
    end

    for i = #self.entities, 1, -1 do
        if not self.objects[i] then
            table.remove(self.objects, i)
        end
    end
end

function GameLevel:update(dt)
    self.tileMap:update(dt)

    for k, object in pairs(self.objects) do
        object:update(dt)
    end

    for k, entity in pairs(self.entities) do
        entity:update(dt)
    end
end

function GameLevel:render()
    self.tileMap:render()

    for k, object in pairs(self.objects) do
        object:render()
    end

    for k, entity in pairs(self.entities) do
        entity:render()
    end
end

--[[Gets a safe set of pixel coordinates at which to spawn the player.
We'll just check for the first x coordinate that isn't a chasm.
]]
function GameLevel:getFirstSafeSpawnX()
    --Go through the level and check each tile x for a chasm. First one without a chasm is our safe spawn x value.
    for tile_x = 1, self.tileMap.width, 1 do
        if not self:checkForChasm(tile_x) then
            return tile_x
        end
    end
    --If we haven't found any chasmless locations, we're in trouble!
    return nil
    
end


function GameLevel:getFlagSpawnX()
    --Find the farthest 'safe' location for a flag.
    for tile_x = self.tileMap.width, 1, -1 do
        
        if not self:checkForChasm(tile_x) then
            return tile_x
        end

    end

    -- This should not happen!
    return nil

end

--Check for a chasm at a given x-coordinate.
function GameLevel:checkForChasm(tile_x)
    --local tile_x = (pixel_x + 1) / TILE_SIZE


    --Basically check an entire column in the tiles array for collidability.
    for tile_y = 1, self.tileMap.height, 1 do
        if(self.tileMap.tiles[tile_y][tile_x]:collidable()) then
            return false
        end

    end

    return true


end

--Gets the lowest sky tile at a given column
function GameLevel:lowestEmptySpace(tile_x)

    for tile_y = 1, self.tileMap.height, 1 do
        if( self.tileMap.tiles[tile_y][tile_x]:collidable()) then
            return tile_y
        end
    end

    return nil
    
end

function GameLevel:spawnFlag()
    for tile_x = self.tileMap.width, 1, -1 do
        
        if not self:checkForChasm(tile_x) then
            local base, mid, top = CreateFlagpole(ToPixelCoord(tile_x), ToPixelCoord(self:lowestEmptySpace(tile_x)))
            table.insert(self.objects, base)
            table.insert(self.objects, mid)
            table.insert(self.objects, top)
            break
        end

    end
end

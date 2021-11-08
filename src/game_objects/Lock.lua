


function CreateLock(x,y,color)
    local obj = GameObject({

        x = x,
        y = y,
        texture = 'keys-and-locks',
        width = TILE_SIZE,
        height = TILE_SIZE,
        frame = LOCKS[color],
        solid = true,
        collidable = true,
        consumable = false,
        onCollide = function (object, player)
            if player.hasKey == true then
                gSounds['pickup']:play()
                
                player.level:spawnFlag()
                -- Mark for deletion. The clear() function should take care of any references in the object list.
                object.shouldDelete = true

            end
        end,





    })

    return obj
end
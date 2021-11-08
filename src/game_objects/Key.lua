



-- 'Color' is the index into their global game object ID lists, because I want the colors to match. 
function CreateKey(x,y, color)

    local obj = GameObject({

        x = x,
        y = y,
        texture = 'keys-and-locks',
        width = TILE_SIZE,
        height = TILE_SIZE,
        frame = KEYS[color],
        solid = false,
        collidable = true,
        consumable = true,
        onConsume = function (player)
            gSounds['pickup']:play()
            player.hasKey = true
            --print("Player hasKey: ".. player.hasKey)
        end,





    })

    return obj

    
end
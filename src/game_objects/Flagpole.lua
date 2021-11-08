

FlagpolePiece = Class{__includes = GameObject}


function FlagpolePiece:init(def)
    GameObject.init(self,def)
    self.height = 16
    self.width = 10
    self.texture = 'flags'
    self.flagTop = def.flagTop


end

function FlagpolePiece:update(dt)
    GameObject.update(self,dt)
end

function FlagpolePiece:render()
    GameObject.render(self)
    
end

function FlagpolePiece:onCollide(player)
    --The flagpole pieces need to collide, and they need to be solid to do it. But we want to be able to pass through them.
    self.solid = false

    if not player.playerTouchedFlagpole then
        player.playerTouchedFlagpole = true
        -- Play a triumphant noise. 
        gSounds.victory:play()

        if self.flagTop then
                -- Spawn a waving flag on the pole.
            FlagInstance = Flag ({
                x = self.flagTop.x - 8,
                y = self.flagTop.y,
                width = 10,
                height = 16,
                texture = 'flags',
                stateMachine = StateMachine {
                    ['idle'] = function () return FlagIdleState(FlagInstance) end
                },
                map = player.level.tileMap,
                level = player.level


            })
        else
            -- Spawn a waving flag on the pole.
            FlagInstance = Flag ({
                x = self.x - 8,
                y = self.y,
                width = 10,
                height = 16,
                texture = 'flags',
                stateMachine = StateMachine {
                    ['idle'] = function () return FlagIdleState(FlagInstance) end
                },
                map = player.level.tileMap,
                level = player.level


            })
        end

        FlagInstance:changeState('idle')
        table.insert(player.level.entities, FlagInstance)

        --Do a little trick to make it seem like we can still pass through the flagpole.

        Timer.after(2, function ()
            gStateMachine:change('play', {score = player.score, chapter = gStateMachine.current.chapter + 1}) 
        end)
    end


    
end


-- Given a pixel x, y, place an entire flagpole, with the bottom of the sprite at the x,y coordinates.
function CreateFlagpole(x,y)
    local top = CreateFlagTop(x, y - 48)

    local base = CreateFlagBase(x, y - 16, top)
    local mid = CreateFlagMid(x, y - 32, top)
    
    return base, mid, top

end

function CreateFlagBase(x,y, flagTop)
    local obj = FlagpolePiece {
        x = x,
        y = y,
        frame = FLAGPOLE[1],
        solid = true,
        flagTop = flagTop

    }

    return obj
    
end

function CreateFlagMid(x,y, flagTop)
    local obj = FlagpolePiece {
        x = x,
        y = y,
        frame = FLAGPOLE[2],
        solid = true,
        flagTop = flagTop
    }

    return obj
end

function CreateFlagTop(x,y)
    local obj = FlagpolePiece {
        x = x,
        y = y,
        frame = FLAGPOLE[3],
        solid = true

    }

    return obj
end
--[[
    Gamble
    This function returns true with a certain probability (1-100), false otherwise.
    Assumes that math.random has been seeded already, doesn't seed it itself.
]]
function Gamble(probability)
    local rand = math.random(1,100)
    if(rand <= probability) then
        return true
    
    else
        return false
    end

end




FlagIdleState = Class{__includes = BaseState}



function FlagIdleState:init(flag)
    self.flag = flag
    self.animation = Animation {
        frames = {FLAG[1],FLAG[2],FLAG[3]},
        interval = 0.5
    }

    self.flag.currentAnimation = self.animation
end


function FlagIdleState:update(dt)
    self.flag.currentAnimation:update(dt)
    
end




Flag = Class{__includes = Entity}



function Flag:init(def)
    Entity.init(self,def)
end

function Flag:update(dt)
    Entity.update(self,dt)
end

function Flag:render()
    Entity.render(self)
end
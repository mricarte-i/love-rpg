--local CollisionSystem = Manager:filter {"body", "collider"}
local CollisionSystem = Manager:filter {"body"}

function CollisionSystem:interact(entity, entities, dt)
    --local collider = entity:get("collider")
    local body = entity:get("body")

    print("interacting!")
    for i=#entities, 1, -1 do
        print("COLLIDING")
        --if checkAABB(entity, self.entities[i]) then
        --end
    end

end
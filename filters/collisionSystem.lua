--local CollisionSystem = Manager:filter {"body", "collider"}
local CollisionSystem = Manager:filter {"body", "collider"}

local function checkAABB(o1, o2)
    local body1 = o1:get("body")
    local body2 = o2:get("body")
    --print("o1:", dumpTable(body1))
    --print("o2:", dumpTable(body2))
    return body1:contains(body2)

end


function CollisionSystem:interact(entity, entities, dt)
    local collider = entity:get("collider")
    local body = entity:get("body")

    --print("interacting!")
    for i=#entities, 1, -1 do
        --print("COLLIDING?")
        --print("o1:", dumpTable(entity))
        --print("o2:", entities[i]:has("collider"))
        if entities[i]:has("body") and entities[i].id ~= entity.id then
            if checkAABB(entity, entities[i]) then
                collider.onCollision(entities[i], entity)
            end
        end
    end

end
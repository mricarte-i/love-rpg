local PhysicsSystem = Manager:filter {"body", "physics"}
local createBody = require "comps/body"


function PhysicsSystem:update(entity, dt)
    local physics = entity:get("physics")
    local body = entity:get("body")

    if(body == nil) then
        print("WHY")
    end
    local xbody = createBody(
        body.x + physics.vx * dt,
        body.y
    )

    local ybody = createBody(
        body.x,
        body.y + physics.vy * dt
    )


    body.x = xbody.x
    body.y = ybody.y

    physics.vx = physics.vx * math.pow(physics.friction, dt)
    physics.vy = physics.vy * math.pow(physics.friction, dt)

end
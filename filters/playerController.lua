local PlayerController = Manager:filter {"body", "physics", "statemachine", "player"}
local createBody = require "comps/body"
require "utils"


function PlayerController:update(entity, dt)
    local physics = entity:get("physics")
    local body = entity:get("body")
    local state = entity:get("statemachine")

    --on the first frame, state has a pointer, second frame its nil, third has a pointer....
    --local flag = true
    --if state == nil then
        --flag = false
    --end

    --print("entity:", entity.id)

    if love.keyboard.isDown("a") then
        physics.vx = physics.vx - physics.speedx * dt
        --if flag then
            state:setState("walk")
        --end
    end
    if love.keyboard.isDown("d") then
        physics.vx = physics.vx + physics.speedx * dt
        --if flag then
            state:setState("walk")
        --end
    end
    if love.keyboard.isDown("w") then
        physics.vy = physics.vy - physics.speedy * dt
        --if flag then
            state:setState("idle")
        --end
    end
    if love.keyboard.isDown("s") then
        physics.vy = physics.vy + physics.speedy * dt
        --if flag then
            state:setState("idle")
        --end
    end

end
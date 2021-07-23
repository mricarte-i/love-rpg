local PlayerController = Manager:filter {"body", "physics", "statemachine"}
local createBody = require "comps/body"


function PlayerController:update(entity, dt)
    local physics = entity:get("physics")
    local body = entity:get("body")
    local state = entity:get("statemachine")

    if love.keyboard.isDown("a") then
        physics.vx = physics.vx - physics.speedx * dt
        state:setState("walk")
    end
    if love.keyboard.isDown("d") then
        physics.vx = physics.vx + physics.speedx * dt
        state:setState("walk")
    end
    if love.keyboard.isDown("w") then
        physics.vy = physics.vy - physics.speedy * dt
        state:setState("idle")
    end
    if love.keyboard.isDown("s") then
        physics.vy = physics.vy + physics.speedy * dt
        state:setState("idle")
    end

end
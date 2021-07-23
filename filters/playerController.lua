local PlayerController = Manager:filter {"body", "physics"}
local createBody = require "comps/body"


function PlayerController:update(entity, dt)
    local physics = entity:get("physics")
    local body = entity:get("body")

    if love.keyboard.isDown("a") then
        physics.vx = physics.vx - physics.speedx * dt
    end
    if love.keyboard.isDown("d") then
        physics.vx = physics.vx + physics.speedx * dt
    end
    if love.keyboard.isDown("w") then
        physics.vy = physics.vy - physics.speedy * dt
    end
    if love.keyboard.isDown("s") then
        physics.vy = physics.vy + physics.speedy * dt
    end

end
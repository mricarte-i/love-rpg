Manager = require "entities"

require "filters/entityRenderer"
require "filters/physicsSystem"
require "comps/comp"

local createBody = require "comps/body"
local createDrawable = require "comps/drawable"
local createPhysics = require "comps/physics"

gGame = require "game"


function love.load()
    local player = Manager:create()

    player:add(createBody(10, 10, 100, 100))
    player:add(createDrawable("rect", {1, 0, 0, 1}))
    player:add(createPhysics(100, 0))

    print(player:get("body").x)

end

function love.update(dt)
    Manager:update(dt)
end

function love.draw()
    Manager:render()
    --love.graphics.rectangle("fill", 0, 0, 100, 100)
end
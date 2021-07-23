Manager = require "entities"

require "filters/entityRenderer"
require "comps/comp"

local createBody = require "comps/body"
local createDrawable = require "comps/drawable"

gGame = require "game"


function love.load()
    local player = Manager:create()

    player:add(createBody(10, 10, 100, 100))
    player:add(createDrawable("rect", {1, 0, 0, 1}))

    print(player:get("body").x)

end

function love.update(dt)
    Manager:update(dt)
end

function love.draw()
    Manager:render()
    --love.graphics.rectangle("fill", 0, 0, 100, 100)
end
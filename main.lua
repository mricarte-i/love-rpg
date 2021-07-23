Manager = require "entities"

require "filters/entityRenderer"
require "filters/physicsSystem"
require "filters/playerController"
require "comps/comp"

local createBody = require "comps/body"
local createDrawable = require "comps/drawable"
local createPhysics = require "comps/physics"
local createPlayer = require "comps/player"

gGame = require "game"




function love.load()
    local player = Manager:create()

    player:add(createBody(10, 10, 24, 24))
    player:add(createDrawable("rect", {0.5, 0.4, 0, 1}))
    player:add(createPhysics(0, 0, 0.01, 200, 200))
    player:add(createPlayer())

    print(player:get("body").x)

    --simpleScale thx
    scale = {
        gameWidth = 256,
        gameHeight = 224,
        scaleType = 1,
        settings = {
            fullscreen = false,
            resizable = true
        },
        windowWidth = 1280,
        windowHeight = 720
    }
    love.graphics.setDefaultFilter("nearest", "nearest")
    require "lib/simpleScale"
    simpleScale.setWindow(scale.gameWidth, scale.gameHeight, scale.windowWidth, scale.windowHeight, scale.settings)

end

function love.resize()
    simpleScale.resizeUpdate()
end

function love.update(dt)
    Manager:update(dt)
end

function love.draw()
    simpleScale.set()

    Manager:render()
    --love.graphics.rectangle("fill", 0, 0, 100, 100)
    simpleScale.unSet()
end
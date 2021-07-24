Manager = require "entities"

require "filters/entityRenderer"
require "filters/physicsSystem"
require "filters/playerController"
require "filters/collisionSystem"
require "comps/comp"

local createBody = require "comps/body"
local createDrawable = require "comps/drawable"
local createPhysics = require "comps/physics"
local createPlayer = require "comps/player"
local createSpriteAnimation = require "comps/sprite"
local createStateMachine = require "comps/state"
local createCollider = require "comps/collider"


gGame = require "game"

require "utils"


function love.load()

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

    local player = Manager:create()

    player:add(createBody(0, 0, 24, 24))
    player:add(createPhysics(0, 0, 0.01, 500, 500))
    player:add(createPlayer())

    player:add(
        createCollider(
            function (other, me)
                print("player colliding")
            end
        )
    )

    --player:add(createDrawable("rect", {0.5, 0.4, 0, 1}))

    player:add(
            createDrawable(
                "spriteanimation",
                { 1, 1, 1, 1 },
                {
                    { name="idle", animation = createSpriteAnimation("assets/spritesheets/char-animations.png", 0, 0, 24, 24, 4)},
                    { name="walk", animation = createSpriteAnimation("assets/spritesheets/char-animations.png", 0, 24, 24, 24, 4)},
                },
                "assets/spritesheets/char-animations.png"
            )
    )

    player:add(createStateMachine({
        {name="idle"},
        {name="walk"}
    }, {name="idle"}))

    --player:add(createSpriteAnimation("assets/spritesheets/char-animations.png", 0, 0, 24, 24, 4))

    --print(player:get("body").x)

    local enemy = Manager:create()
    enemy:add(createBody(40, 10, 24, 24))
    enemy:add(createPhysics(0, 0, 0.01, 500, 500))
    enemy:add(createDrawable("rect", {1, 0, 0, 1}))
    enemy:add(
        createCollider(
            function (other, me)
                print("enemy colliding")
            end
        )
    )

    local tile = Manager:create()
    tile:add(createBody(50, 50, 24, 24))
    tile:add(createPhysics(0, 0, 0.01, 500, 500))
    tile:add(createDrawable("rect", {0.2, 0.4, 0.5, 1}))
    tile:add(
        createCollider(
            function (other, me)
                print("tile colliding with: ", other.id)
                if other:has("physics") then
                    local obody = other:get("body")
                    local ophysics = other:get("physics")
                    local mbody = me:get("body")

                    print("x is : ", obody.x)
                    print("y is : ", obody.y)

                    local aux, auy = 0 , 0

                    --if obody.x + obody.width < mbody.x then
                    if obody.x + obody.width > mbody.x then
                        ophysics.vx = - ophysics.vx
                        aux = obody.x - (obody.x + obody.width - mbody.x)
                    --elseif obody.x > mbody.x + mbody.width then
                    end
                    if obody.x < mbody.x + mbody.width then
                        ophysics.vx = -ophysics.vx
                        aux = obody.x + (mbody.x + mbody.width - obody.x)
                    end

                    --if obody.y + obody.height < mbody.y then
                    if obody.y + obody.height > mbody.y then
                        ophysics.vy = -ophysics.vy
                        auy = obody.y - (obody.y + obody.height - mbody.y)
                    --elseif obody.y > mbody.y + mbody.height then
                    end
                    if obody.y < mbody.y + mbody.height then
                        ophysics.vy = -ophysics.vy
                        auy = obody.y + (mbody.y + mbody.height - obody.y)
                    end

                    print("aux is : ", aux)
                    print("auy is : ", auy)

                    local xbody = createBody {
                        --aux,
                        obody.x,
                        obody.y
                    }
                    local ybody = createBody {
                        obody.x,
                        --auy
                        obody.y
                    }

                    obody.x = aux
                    obody.y = auy
                    print("x is : ", obody.x)
                    print("y is : ", obody.y)

                end
            end
        )
    )



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
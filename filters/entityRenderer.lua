local EntityRenderer = Manager:filter {"body", "drawable"}
require "utils"


function EntityRenderer:render(entity)
    local drawable = entity:get("drawable")
    local body = entity:get("body")

    --print(dumpTable(drawable))
    --print(dumpTable(drawable.animations[1].animation.frames))
    --print(drawable.currentFrame)
    --print(drawable.animations[1].animation.frames[drawable.currentFrame])

    --print(dumpTable(drawable:getAnimation("idle")))

    if drawable.type == "rect" then
        love.graphics.setColor(unpack(drawable.color))
        love.graphics.rectangle(
            "fill",
            body.x,
            body.y,
            body.width,
            body.height
        )
    elseif drawable.type == "spriteanimation" then
        assert(entity:has("statemachine"))
        local state = entity:get("statemachine")

        print("current:",state.current)
        print("animation:", dumpTable(drawable:getAnimation(state.current)[1]))
        love.graphics.draw(
            drawable:getAnimation(state.current)[1].spritesheet,
            drawable:getAnimation(state.current)[1].frames[drawable.currentFrame],
            body.x,
            body.y
        )
    else
        assert(false, string.format("Entity renderer does not support the drawable type [%s]", drawable.type))
    end
end

function EntityRenderer:update(entity, dt)
    local drawable = entity:get("drawable")
    drawable.timeSinceLastFrame = drawable.timeSinceLastFrame + dt

    if drawable.type == "spriteanimation" then
        assert(entity:has("statemachine"))
        local state = entity:get("statemachine")

        --print(dumpTable(drawable:getAnimation(state.current)))
        --print(drawable.timeSinceLastFrame)
        --print(drawable:getAnimation(state.current)[1].frameDuration)

        if drawable.timeSinceLastFrame > drawable:getAnimation(state.current)[1].frameDuration then
            drawable.timeSinceLastFrame = drawable.timeSinceLastFrame - drawable:getAnimation(state.current)[1].frameDuration
            drawable.currentFrame = drawable.currentFrame % drawable:getAnimation(state.current)[1].totalFrames + 1
        end
    end

end
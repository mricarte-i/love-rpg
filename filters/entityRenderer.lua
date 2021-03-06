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

        love.graphics.setColor(unpack(drawable.color))
        --print("current:",state.current.name)
        --print("animation:", dumpTable(drawable:getAnimation(state.current.name)))
        love.graphics.draw(
            drawable:getAnimation(state.current.name).spritesheet,
            drawable:getAnimation(state.current.name).frames[drawable.currentFrame],
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

        --print(state.current.name)
        --print(dumpTable(drawable:getAnimation(state.current.name)))
        --print(drawable.timeSinceLastFrame)
        --print(drawable:getAnimation(state.current.name).frameDuration)

        if drawable.timeSinceLastFrame > drawable:getAnimation(state.current.name).frameDuration then
            drawable.timeSinceLastFrame = drawable.timeSinceLastFrame - drawable:getAnimation(state.current.name).frameDuration
            drawable.currentFrame = drawable.currentFrame % drawable:getAnimation(state.current.name).totalFrames + 1
        end
    end

end
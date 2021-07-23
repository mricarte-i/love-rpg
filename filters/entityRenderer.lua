local EntityRenderer = Manager:filter {"body", "drawable"}
require "utils"


function EntityRenderer:render(entity)
    local drawable = entity:get("drawable")
    local body = entity:get("body")

    --print(dumpTable(drawable))
    --print(dumpTable(drawable.animations[1].animation.frames))
    --print(drawable.currentFrame)
    --print(drawable.animations[1].animation.frames[drawable.currentFrame])

    print(dumpTable(drawable:getAnimation("idle")))

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
        love.graphics.draw(
            drawable.animations[1].animation.spritesheet,
            --drawable.animations[1].animation.frames[drawable.currentFrame],
            drawable:getAnimation("idle").animation.frames[drawable.currentFrame],
            body.x,
            body.y
        )
    else
        assert(false, string.format("Entity renderer does not support the drawable type [%s]", drawable.type))
    end
end
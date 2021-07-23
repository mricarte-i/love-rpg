local function createDrawable(theType, color, animations, spritesheet)
    if spritesheet ~= nil then
        assert(type(spritesheet) == 'string')
    end
    return createComp {
        name_ = "drawable",
        type = theType,
        color = color or { 1 , 1 , 1, 1 },
        animations = animations or {},
        spritesheet = spritesheet or "",
        currentFrame = 1,
    }
end

return createDrawable
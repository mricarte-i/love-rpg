local function createDrawable(theType, color, animations, spritesheet)

    if spritesheet ~= nil then
        assert(type(spritesheet) == 'string')
    end

    local getAnim

    if animations ~= nil then
        getAnim = function (self, name)
            for i=1, #self.animations do
                if self.animations[i].name == name then
                    return self.animations[i]
                end
            end
            return self.animations[1]
        end
    else
        getAnim = function (self, name)
        end
    end


    return createComp {
        name_ = "drawable",
        type = theType,
        color = color or { 1 , 1 , 1, 1 },
        animations = animations or {},
        spritesheet = spritesheet or "",
        currentFrame = 1,
        getAnimation = getAnim,
    }
end

return createDrawable
require "utils"

local function createDrawable(theType, color, animations, spritesheet)

    if spritesheet ~= nil then
        assert(type(spritesheet) == 'string')
    end

    local getAnim

    if animations ~= nil then
        getAnim = function (self, name)
            --print("getting anim:", name)
            for i=1, #self.animations do
                --print("reading through:", dumpTable(self.animations[i]))
                if self.animations[i].name == name then
                    --print("got anim:", self.animations[i].animation)
                    return self.animations[i].animation
                end
            end
            --print("got anim:", self.animations[1].animation)
            return self.animations[1].animation
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
        timeSinceLastFrame = 0,
    }
end

return createDrawable
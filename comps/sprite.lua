-- @param ssf : spritesheet file path
-- @param x : from which horizontal pixel of the original image to splice the frames
-- @param y : from which vertical pixel of the original image to splice the frames
-- @param fw : frame width
-- @param fh : frame height
-- @param tf : total number of frames
-- @param fd : frame duration (how long between one from and the other)

-- !! assumption : in the spritesheet, an animation goes form left to right, always within one row

local function createSpriteAnimation(ssf, x, y, fw, fh, tf, fd)

    --always assert your code
    assert(ssf ~= nil)
    assert(type(ssf) == "string")

    assert(tf ~= nil)
    assert(type(tf) == "number")
    assert(tf >= 1)

    assert(fw ~= nil)
    assert(type(fw) == "number")
    assert(fw >= 1)

    assert(fh ~= nil)
    assert(type(fh) == "number")
    assert(fh >= 1)

    local x = x or 0
    local y = y or 0

    local spritesheet = love.graphics.newImage(ssf)
    local frames = {}
    for frame = 1, tf do
        frames[frame] = love.graphics.newQuad(x + (frame - 1) * fw, y, fw, fh, spritesheet:getDimensions())
    end

    return createComp {
        name_ = "spriteanimation",
        spritesheet = spritesheet,
        frames = frames,
        totalFrames = tf,
        frameDuration = fd or 0.15,
    }
end

return createSpriteAnimation
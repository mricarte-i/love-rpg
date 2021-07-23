local function createBody(x, y, width, height)
    return createComp {
        name_ = "body",
        x = x,
        y = y,
        width = width,
        height = height,
    }
end

return createBody
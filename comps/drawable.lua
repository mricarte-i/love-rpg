local function createDrawable(theType, color)
    return createComp {
        name_ = "drawable",
        type = theType,
        color = color or { 1 , 1 , 1, 1 }
    }
end

return createDrawable
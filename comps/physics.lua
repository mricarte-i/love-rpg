local function createPhysics(vx, vy)
    return createComp {
        name_ = "physics",
        vx = vx,
        vy = vy,
        friction =  0.02,
        speedx = 3200,
        speedy = 3200,

    }
end

return createPhysics
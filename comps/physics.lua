local function createPhysics(vx, vy, friction, speedx, speedy)
    return createComp {
        name_ = "physics",
        vx = vx,
        vy = vy,
        friction = friction or 0.02,
        speedx = speedx or 3200,
        speedy = speedy or 3200,

    }
end

return createPhysics
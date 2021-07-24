require "utils"

-- @param : onCollider is a function that's called when an entity's body overlaps with another's body, it can be used for interactions and such

-- ?? in the future, onCollision might not only get the param other, but maybe both entities (self and other), so that we can check information on the other and the container entity (is other a door? are we on the "stabbing" state? is the other an enemy?)


local function createCollider(onCollision)
    if onCollision == nil then
        onCollision = function(other, me)
        end
    end

    return createComp {
        name_ = "collider",
        onCollision = onCollision,
    }
end

return createCollider
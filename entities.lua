require "utils"

local _id = 0

local manager = {
    entities = {},
    filters = {}
}

function manager:update(dt)
    for i, ent in ipairs(self.entities) do
        for j, filter in ipairs(self.filters) do
            if filter:matches(ent) then
                filter:update(ent, dt)
                if not ent.loaded then
                    filter:load(ent)
                end
            end
        end
        ent.loaded = true
    end
end

function manager:render()
    for i, ent in ipairs(self.entities) do
        for j, filter in ipairs(self.filters) do
            if filter:matches(ent) then
                filter:render(ent)
            end
        end
    end
end


function manager:filter(matchList)
    local filter = {
        matchList = matchList or {},
        load = function(self, entity)
        end,
        update = function(self, entity, dt)
        end,
        render = function(self, entity)
        end,
        destroy = function(self, entity)
        end
    }

    function filter:matches(ent)
        for i, match in ipairs(self.matchList) do
            if not ent:has(match) then
                return false
            end
        end
        return true
    end

    table.insert(self.filters, filter)
    return filter
end

--lua variable number of arguments ==> (...)
function manager:create()
    local entity = {
        loaded = false,
        id = _id,
        components = {},
    }
    _id = _id + 1
    table.insert(self.entities, entity)

    function entity:add(comp)
        self.components[comp.name_] = comp
    end

    function entity:get(name)
        return self.components[name]
    end

    function entity:has(name)
        return self.components[name] ~= nil
    end

    return entity
end

return manager
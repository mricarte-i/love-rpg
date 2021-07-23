local function createStateMachine(states, default)
    assert(states ~= nil)
    assert(#states >= 1)
    return createComp {
        name_ = "statemachine",
        states = states,
        current = default or states[1],
        getState = function(self, name)
            for i=1, #self.states do
                if self.states[i].name == name then
                    return self.states[i]
                end
            end
            return self.states[1]
        end,
        setState = function(self, name)
            local state = self:getState(name)

            if self:getState(name) == self.states[1] and self.states[1].name ~= name then
            else
                self.current = state.name
            end
        end,
    }
end
return createStateMachine
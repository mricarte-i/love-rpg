local function createBody(x, y, width, height)
    return createComp {
        name_ = "body",
        x = x,
        y = y,
        width = width,
        height = height,

        center = function(self)
            return {
                x + width * 0.5,
                y + height * 0.5,
            }
        end,

        contains = function(self, other)
            assert(type(other) == "table")
            assert(other.name_ == "body")
            return self.x + self.width > other.x and
                    self.x < other.x + other.width and
                    self.y + self.height > other.y and
                    self.y < other.y + other.height
        end,
    }
end

return createBody
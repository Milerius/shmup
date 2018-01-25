-- player.rotate

local LEFT = 71 ; local RIGHT = 72
local rotation = self:getRotationComponent()

rotate = {
    on = function(key)

        local factors = {}
        factors[LEFT] = 1
        factors[RIGHT] = -1

        rotation.rotation = factors[key]
    end,
    off = function()
        rotation.rotation = 0
    end
}

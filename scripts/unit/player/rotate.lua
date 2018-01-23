-- player.rotate

local LEFT = 71 ; local RIGHT = 72
local transform = self:getTransformComponent()
local meta = self:getLuaComponent().meta

rotate = {
    on = function(key)
        local ANGLE_MOD = 0.2

        local factors = {}
        factors[LEFT] = 1
        factors[RIGHT] = -1

        meta.rotation = ANGLE_MOD * factors[key]
    end,
    off = function()
        meta.rotation = 0
    end
}

table.insert(player.update, function()
    transform.yaw = transform.yaw + meta.rotation
end)

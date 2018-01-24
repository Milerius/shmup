-- player.input

local SPACE = 57
local LEFT = 71 ; local RIGHT = 72 ; local UP = 73 ; local DOWN = 74

local thrust = self:getThrustComponent()
local blaster = self:getBlasterComponent()

table.insert(player.init, function()
    local keyFuncs = {}
    keyFuncs[SPACE] = {
        onPress = function() blaster.firing = true end,
        onRelease = function() blaster.firing = false end
    }

    keyFuncs[UP] = {
        onPress = function () thrust.on = true end,
        onRelease = function() thrust.on = false end
    }

    keyFuncs[LEFT] = {
        onPress = rotate.on,
        onRelease = rotate.off
    }

    keyFuncs[RIGHT] = {
        onPress = rotate.on,
        onRelease = rotate.off
    }

    local function onPress(key)
        local func = keyFuncs[key]
        if func and func.onPress then
            func.onPress(key)
        end
    end

    local function onRelease(key)
        local func = keyFuncs[key]
        if func and func.onRelease then
            func.onRelease(key)
        end
    end

    setKeyHandler(onPress, onRelease)
end)

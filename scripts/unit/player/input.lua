-- player.input

local SPACE = 57
local LEFT = 71 ; local RIGHT = 72 ; local UP = 73 ; local DOWN = 74

local thrust = self:getThrustComponent()

table.insert(player.init, function()
    local keyFuncs = {}
    keyFuncs[SPACE] = { onPress = shoot }
    keyFuncs[LEFT] = { onPress = rotate.on, onRelease = rotate.off }
    keyFuncs[RIGHT] = { onPress = rotate.on, onRelease = rotate.off }
    keyFuncs[UP] = {
        onPress = function ()
            thrust.on = true
        end, onRelease = function()
            thrust.on = false
        end
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

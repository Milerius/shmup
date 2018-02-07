-- player.input

local SPACE = 57
local LEFT = 71 ; local RIGHT = 72 ; local UP = 73 ; local DOWN = 74
local W = 22 ; local S = 18 ; local A = 0 ; local D = 3

local thrust = self:getThrustComponent()
local blaster = self:getBlasterComponent()
local rotation = self:getRotationComponent()

local keyFuncs = {}

keyFuncs[SPACE] = function (pressed)
    blaster.firing = pressed
end

keyFuncs[UP] = function (pressed)
    thrust.on = pressed
end

keyFuncs[LEFT] = function (pressed)
    if pressed then
        rotation.rotation = 1
    else
        rotation.rotation = 0
    end
end

keyFuncs[RIGHT] = function (pressed)
    if pressed then
        rotation.rotation = -1
    else
        rotation.rotation = 0
    end
end

keyFuncs[W] = keyFuncs[UP]
keyFuncs[S] = keyFuncs[DOWN]
keyFuncs[A] = keyFuncs[LEFT]
keyFuncs[D] = keyFuncs[RIGHT]

local function onKey(key, pressed)
    local func = keyFuncs[key]
    if func then
        func(pressed)
    end
end

self:attachInputComponent().onKey = onKey

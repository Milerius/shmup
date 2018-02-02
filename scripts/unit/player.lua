-- player

local SCREEN = { x = 20, z = 11.25 }

local me = self
local transform = self:getTransformComponent()

local LASER = "player"

local function collideWith(_, go)
    if go:hasLaserComponent() and go:getLaserComponent().type == LASER then
        return
    end

    print("You lose!")
    __state__ = "gameover"
end

local function laserHit(laser, go)
    if go:hasLaserComponent() or go == me then
        return
    end
    SCORE = SCORE + 1
end

-- init

local meta = self:getLuaComponent().meta
if not meta.init then
    meta.init = true
    SCORE = 0

    meta.onCollision = collideWith

    dofile "scripts/unit/player/input.lua"
    return
end

-- main

getEntity("score"):getGUIComponent().text = "Score: " .. SCORE

for _, go in ipairs(getGameObjectsWithLaserComponent()) do
    if go:getLaserComponent().type == LASER and not go:hasLuaComponent() then
        go:attachLuaComponent().meta = { onCollision = laserHit }
    end
end

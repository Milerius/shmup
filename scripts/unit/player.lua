-- player

local SCREEN = { x = 20, z = 11.25 }

local me = self
local transform = self:getTransformComponent()

local LASER = "player"

function collideWith(_, go)
    if go:hasLaserComponent() and go:getLaserComponent().type == LASER then
        return
    end

    print("You lose!")
    __state__ = "gameover"
end

function laserHit(laser, go)
    if go:hasLaserComponent() or go == me then
        return
    end
    removeEntity(laser)
    removeEntity(go)
    SCORE = SCORE + 1
end

-- init

local meta = self:getLuaComponent().meta
if not meta.init then
    meta.init = true

    meta.onCollision = collideWith

    SCORE = 0
    self:getRotationComponent().rotationSpeed = 0.075

    self:getBlasterComponent().shootDelay = 10

    player = { init = {}, update = {} }
    dofile "scripts/unit/player/rotate.lua"
    dofile "scripts/unit/player/collision.lua"
    dofile "scripts/unit/player/input.lua"

    for _, f in pairs(player.init) do
        f()
    end

    return
end

-- main

for _, f in pairs(player.update) do
    f()
end

getEntity("score"):getGUIComponent().text = "Score: " .. SCORE

for _, go in ipairs(getGameObjectsWithLaserComponent()) do
    if go:getLaserComponent().type == LASER and not go:hasLuaComponent() then
        go:attachLuaComponent().meta = { onCollision = laserHit }
    end
end

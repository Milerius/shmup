-- player

local me = self
local transform = self:getTransformComponent()

local LASER = "player"

function collideWith(name)
    local go = getEntity(name)
    if go:hasLaserComponent() and go:getLaserComponent().type == LASER then
        return
    end

    print("You lose!")
    __state__ = "gameover"
end

function laserHit(laser, name)
    local go = getEntity(name)
    if go:hasLaserComponent() or name == me:getName() then
        return
    end
    removeEntity(laser)
    removeEntity(name)
    SCORE = SCORE + 1
end

-- init

local meta = self:getLuaComponent().meta
if not meta.init then
    meta.init = true
    meta.rotation = 0

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

-- main helpers

local function limitBoundaries()
    local LIMITS = { x = 19, z = 10 }

    local pos = transform.boundingBox.topLeft
    if pos.x < 0 then
        pos.x = 0
    elseif pos.x > LIMITS.x then
        pos.x = LIMITS.x
    end

    if pos.z < 0 then
        pos.z = 0
    elseif pos.z > LIMITS.z then
        pos.z = LIMITS.z
    end
end

limitBoundaries()
for _, f in pairs(player.update) do
    f()
end

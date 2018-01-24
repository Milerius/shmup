-- player

local me = self
local transform = self:getTransformComponent()

local LASER = "FriendlyLaser"

function collideWith(name)
    if string.find(name, LASER) then
        return
    end
    print("You lose!")
    __state__ = "gameover"
end

function laserHit(laser, name)
    if string.find(name, "Laser") or name == me:getName() then
        return
    end
    removeEntity(laser)
    removeEntity(name)
end

function shoot()
    createNoNameEntity(LASER, function (go)
        local box = transform.boundingBox
        local laserTransform = go:getTransformComponent()
        laserTransform.yaw = transform.yaw

        local laserBox = laserTransform.boundingBox
        local pos = laserBox.topLeft
        local size = laserBox.size
        pos.x = box.topLeft.x + (box.size.x / 2) - (size.x / 2) + math.cos(transform.yaw)
        pos.z = box.topLeft.z + (box.size.z / 2) - (size.z / 2) - math.sin(transform.yaw)

        local movement = go:getPhysicsComponent().movement
        movement.x = math.cos(transform.yaw)
        movement.z = -math.sin(transform.yaw)
    end)
end

-- init

local meta = self:getLuaComponent().meta
if not meta.init then
    meta.init = true
    meta.rotation = 0

    player = { init = {}, update = {} }
    dofile "scripts/unit/player/thrust.lua"
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

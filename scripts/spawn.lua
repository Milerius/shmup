-- spawn

if not __state__ or __state__ ~= "running" then
    __spawn_timer__ = nil
    return
end

local WAIT_TIME = 120

if __spawn_timer__ and __spawn_timer__ < WAIT_TIME then
    __spawn_timer__ = __spawn_timer__ + getDeltaFrames()
    return
else
    __spawn_timer__ = 0
end

function createEnemy(coord)
    createNoNameEntity("Enemy", function (go)
        local transform = go:getTransformComponent()
        local pos = transform.boundingBox.topLeft
        pos.x = coord.x
        pos.z = coord.z

        go:getLuaComponent().meta = { target = "player" }
    end)
end

local SCREEN = { x = 22, z = 13.25 }

local playerPos = getEntity("player"):getTransformComponent().boundingBox.topLeft

corners = {
    { x = playerPos.x - SCREEN.x / 2, z = playerPos.z - SCREEN.z / 2 },
    { x = playerPos.x - SCREEN.x / 2, z = playerPos.z + SCREEN.z / 2 },
    { x = playerPos.x + SCREEN.x / 2, z = playerPos.z - SCREEN.z / 2 },
    { x = playerPos.x + SCREEN.x / 2, z = playerPos.z + SCREEN.z / 2 }
}

dofile "scripts/levels/single_two_second.lua"
dofile "scripts/levels/four_two_second.lua"

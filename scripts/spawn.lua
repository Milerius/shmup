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
    createNamelessEntity("Enemy", function (go)
        go:getBlasterComponent().type = "enemy"
        go:getLuaComponent().meta = { target = "player" }

        local transform = go:getTransformComponent()
        local pos = transform.boundingBox.topLeft
        pos.x = coord.x
        pos.z = coord.z
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

local function spawnOne()
    createEnemy(corners[math.random(#corners)])
end

local function spawnFour()
    for _, corner in ipairs(corners) do
        createEnemy(corner)
    end
end

if not SCORE then
    return
end

if SCORE <= 5 then
    spawnOne()
else
    spawnFour()
end

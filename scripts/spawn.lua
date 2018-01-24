-- spawn

if not __state__ or __state__ ~= "running" then
    return
end

local WAIT_TIME = 60

if __spawn_timer__ and __spawn_timer__ < WAIT_TIME then
    __spawn_timer__ = __spawn_timer__ + getDeltaFrames()
    return
else
    __spawn_timer__ = 0
end

local Z_RANGE = 10

local function createEnemy(coord)
    createNoNameEntity("Enemy", function (go)
        local pos = go:getTransformComponent().boundingBox.topLeft
        pos.x = coord.x
        pos.z = coord.z
    end)
end

local function pickCorner()
    local corners = {
        { x = -1, z = -1 },
        { x = 21, z = -1 },
        { x = -1, z = 12 },
        { x = 21, z = 12 }
    }

    return corners[math.random(#corners)]
end

createEnemy(pickCorner())

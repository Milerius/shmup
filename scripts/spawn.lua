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

function createEnemy()
    createNoNameEntity("Enemy", function (go)
        local pos = go:getTransformComponent().boundingBox.topLeft
        pos.x = 21
        pos.z = math.random(0, Z_RANGE)
    end)
end

createEnemy()

-- spawn

if not __state__ or __state__ ~= "running" then
    return
end

local WAIT_TIME = 60

if __spawn_timer__ and __spawn_timer__ < WAIT_TIME then
    __spawn_timer__ = __spawn_timer__ + 1
    return
else
    __spawn_timer__ = 0
end

local X_RANGE = 19

function createEnemy()
    createNoNameEntity("Enemy",
        function (go)
            local pos = go:getTransformComponent().boundingBox.topLeft
            pos.x = math.random(0, X_RANGE)
            pos.z = 0
        end
    )
end

createEnemy()

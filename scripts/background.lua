-- background

if not __state__ or __state__ ~= "running" then
    return
end

local SIZE = 12
local SPEED = 240
if __background_timer__ and __background_timer__ < (SIZE - 1) * SPEED then
    __background_timer__ = __background_timer__ + getDeltaFrames()
    return
else
    __background_timer__ = 0
end

function createBackground(postCreate)
    createNoNameEntity("KinematicObject", function (go)
        go:attachGraphicsComponent().appearance = "resources/Backgrounds/blue.png"
        local box = go:getTransformComponent().boundingBox
        box.size.x = SIZE
        box.size.z = SIZE
        box.topLeft.x = SIZE * 2
        box.topLeft.y = 0
        box.topLeft.z = 0

        local phys = go:getPhysicsComponent()
        phys.movement.x = -1 / SPEED
        phys.solid = false

        if postCreate then
            postCreate(go)
        end
    end)
end

if not __background_first__ then
    createBackground(function (go)
        go:getTransformComponent().boundingBox.topLeft.x = 0
    end)
    createBackground(function (go)
        go:getTransformComponent().boundingBox.topLeft.x = SIZE
    end)
    __background_first__ = true
end

createBackground()

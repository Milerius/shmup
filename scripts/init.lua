-- init

if __state__ then
    return
end
__state__ = "running"

local SPAWN = { x = 9, z = 5 }

math.randomseed(os.time())

createEntity("Player", "player", function(go)
    local thrust = go:attachThrustComponent()
    thrust.thrust = 0.1
    thrust.slowdown = 0.01;

    go:getPhysicsComponent().speed = 0.1;

    go:getLuaComponent().meta = { noCleanup = true }

    local pos = go:getTransformComponent().boundingBox.topLeft
    pos.x = SPAWN.x ; pos.z = SPAWN.z
end)

-- createNoNameEntity("GameObject", function (go)
--     go:attachGraphicsComponent().appearance = "resources/wall.jpg"
--     go:attachTransformComponent()
--
--     local lua = go:attachLuaComponent()
--     lua:attachScript("scripts/unit/border.lua")
--     lua.meta = { target = "player" }
-- end)

-- createEntity("GameObject", "minimap", function (go)
--     local frustrum = go:attachCameraComponent().frustrum
--     frustrum.topLeft.x = -100
--     frustrum.topLeft.z = -100
--     frustrum.size.x = 200
--     frustrum.size.z = 200
--
--     local box = go:attachTransformComponent().boundingBox
--     box.topLeft.x = 0.6
--     box.topLeft.z = 0
--     box.size.x = 0.4
--     box.size.z = 0.4
-- end)

-- createEntity("GameObject", "camera", function (go)
--     local frustrum = go:attachCameraComponent().frustrum
--     frustrum.topLeft.x = 0
--     frustrum.topLeft.z = 0
--     frustrum.size.x = 20
--     frustrum.size.z = 11.25
--     go:attachTransformComponent()
-- end)

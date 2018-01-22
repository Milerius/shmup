-- init

if __state__ then
    return
end
__state__ = "running"

math.randomseed(os.time())

createNoNameEntity("Player", function() end)

createEntity("GameObject", "background", function (go)
    go:attachGraphicsComponent().appearance = "resources/Backgrounds/blue.png"
    local box = go:attachTransformComponent().boundingBox
    box.size.x = 20
    box.size.z = 11.25
    box.topLeft.x = 0
    box.topLeft.y = 0
    box.topLeft.z = 0
end)

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

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
    box.topLeft.y = 0
end)

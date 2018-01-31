-- init

if __state__ then
    return
end
__state__ = "running"

local SPAWN = { x = 9, z = 5 }

math.randomseed(os.time())

createEntity("Player", "player", function(go)
    go:getBlasterComponent().type = "player"

    go:getLuaComponent().meta = {}

    local pos = go:getTransformComponent().boundingBox.topLeft
    pos.x = SPAWN.x ; pos.z = SPAWN.z
end)

if not hasEntity("background") then
    createEntity("GameObject", "background", function (go)
        local graphics = go:attachGraphicsComponent()
        graphics.appearance = "resources/Backgrounds/blue.png"
        graphics.repeated = true

        local box = go:attachTransformComponent().boundingBox
        box.size.x = 4096
        box.size.z = 4096
        box.topLeft.x = -2048
        box.topLeft.y = 0
        box.topLeft.z = -2048

        go:attachLuaComponent().meta = { noCleanup = true }
    end)
end

-- createNoNameEntity("GameObject", function (go)
--     go:attachGraphicsComponent().appearance = "resources/wall.jpg"
--     go:attachTransformComponent()
--
--     local lua = go:attachLuaComponent()
--     lua:attachScript("scripts/unit/border.lua")
--     lua.meta = { target = "player" }
-- end)

for _, go in ipairs(getGameObjectsWithGUIComponent()) do
    go:attachLuaComponent().meta = { noCleanup = true }
end

for _, go in ipairs(getGameObjectsWithCameraComponent()) do
    go:attachLuaComponent().meta = { noCleanup = true }
end

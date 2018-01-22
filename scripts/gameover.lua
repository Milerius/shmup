-- gameover

if not __state__ or __state__ ~= "gameover" then
    return
end
__state__ = "waiting_gameover"

for i, go in ipairs(getGameObjects()) do
    removeEntity(go:getName())
end

collisionHandlers = {}

setKeyHandler(function (key)
    removeEntity("gameover")
    __state__ = nil
end, function (key) end)

createEntity("Text", "gameover", function (go)
    local gui = go:getGUIComponent()
    gui.text = "Game Over"
    gui.font = "resources/font.ttf"
    local pos = go:getTransformComponent().boundingBox.topLeft
    pos.x = 9
    pos.z = 5
end)


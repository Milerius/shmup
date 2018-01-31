-- gameover

if not __state__ or __state__ ~= "gameover" or hasEntity("gameover") then
    return
end
__state__ = "waiting_gameover"

local function cleanup(go)
    if go:hasLuaComponent() then
        local meta = go:getLuaComponent().meta
        if meta and meta.noCleanup then
            return
        end
    end
    removeEntity(go)
end

for _, go in ipairs(getGameObjects()) do
    cleanup(go)
end

createEntity("Text", "gameover", function (go)
    local gui = go:getGUIComponent()
    gui.text = "Score: " .. SCORE
    SCORE = 0

    gui.font = "resources/font.ttf"
    gui.textSize = 40

    local pos = go:getGUIComponent().topLeft
    pos.x = 0.5
    pos.z = 0.5

    go:getTransformComponent().boundingBox.topLeft.y = 10
end)

setKeyHandler(function ()
    removeEntityByName("gameover")
    __state__ = nil
end, function () end)

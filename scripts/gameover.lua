-- gameover

if not __state__ or __state__ ~= "gameover" then
    return
end
__state__ = "waiting_gameover"

local function removeIfNotPermanent(go)
    if go:hasLuaComponent() then
        local meta = go:getLuaComponent().meta
        if meta and meta.permanent then
            return
        end
    end
    removeEntity(go:getName())
end

for _, go in ipairs(getGameObjects()) do
    removeIfNotPermanent(go)
end

collisionHandlers = {}

setKeyHandler(function ()
    removeEntity("gameover")
    __state__ = nil
end, function (key) end)

createEntity("Text", "gameover", function (go)
    local gui = go:getGUIComponent()
    gui.text = "Score: " .. SCORE
    SCORE = 0

    gui.font = "resources/font.ttf"
    gui.textSize = 40

    local pos = go:getTransformComponent().boundingBox.topLeft
    pos.x = 9
    pos.z = 5
    pos.y = 1
end)


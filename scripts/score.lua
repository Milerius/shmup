-- score

if not __state__ or __state__ ~= "running" then
    __score_init__ = nil
    return
end

if not __score_init__ then
    __score_init__ = true
    SCORE = 0

    createEntity("Text", "score", function (go)
        local gui = go:getGUIComponent()
        gui.text = "Score: " .. SCORE
        gui.font = "resources/font.ttf"

        local pos = go:getTransformComponent().boundingBox.topLeft
        pos.x = 18
        pos.y = 10
    end)
end

getEntity("score"):getGUIComponent().text = "Score: " .. SCORE

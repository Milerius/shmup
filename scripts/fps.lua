-- fps

if not __state__ or __state__ ~= "running" then
    __fps_init__ = nil
    return
end

if not __fps_init__ then
    __fps_init__ = true
    FRAMES = 0
    TIME = 0

    createEntity("Text", "fps", function (go)
        local gui = go:getGUIComponent()
        gui.text = "FPS: " .. FRAMES
        gui.font = "resources/font.ttf"

        local pos = go:getTransformComponent().boundingBox.topLeft
        pos.y = 10
    end)
end

FRAMES = FRAMES + 1
TIME = TIME + getDeltaFrames()
if TIME > 60 then
    TIME = TIME - 60
    getEntity("fps"):getGUIComponent().text = "FPS: " .. FRAMES
    FRAMES = 0
end
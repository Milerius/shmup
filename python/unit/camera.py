# camera

cam = pk.self

def onKeyPress(key, pressed):
    global cam

    PAGE_UP = 61
    PAGE_DOWN = 62

    if not pressed and (key == PAGE_UP or key == PAGE_DOWN):
        cam.zoom = 1
    elif key == PAGE_UP:
        cam.zoom = 1.1
    elif key == PAGE_DOWN:
        cam.zoom = 0.9

if not cam.hasInputComponent():
    cam.zoom = 1
    input = cam.attachInputComponent()
    input.onKey = onKeyPress

frustrum = cam.getCameraComponent().frustrum
frustrum.size.x *= cam.zoom
frustrum.size.z *= cam.zoom

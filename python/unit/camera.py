# camera

cam = pk.self

def onKeyPress(key, pressed):
    global cam

    PAGE_UP = 61
    PAGE_DOWN = 62
    Q = 16
    E = 4

    if not pressed:
        cam.zoom = 1
    elif key == PAGE_UP or key == Q:
        cam.zoom = 1.1
    elif key == PAGE_DOWN or key == E:
        cam.zoom = 0.9

if not cam.hasInputComponent():
    cam.zoom = 1
    input = cam.attachInputComponent()
    input.onKey = onKeyPress

frustrum = cam.getCameraComponent().frustrum
frustrum.size.x *= cam.zoom
frustrum.size.z *= cam.zoom

# test

import sys
sys.argv = [ "Kengine" ]

def displayWindow():
    import tkinter as tk
    root = tk.Tk()
    w = tk.Label(root, text = "Hello world")
    w.pack()
    root.mainloop()

def startTkInter():
    from threading import Thread
    thread = Thread(target = displayWindow)
    thread.daemon = True
    thread.start()

if not 'init' in globals():
    global init
    init = True
    startTkInter()

if pk.hasEntity("player"):
    player = pk.getEntity("player")
    if not player.hasPyComponent():
        player.attachPyComponent().attachScript("python/unit/player.py")

if pk.hasEntity("camera"):
    cam = pk.getEntity("camera")
    if not cam.hasPyComponent():
        cam.attachPyComponent().attachScript("python/unit/camera.py")



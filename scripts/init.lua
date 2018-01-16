-- init

if __state__ then
    return
end

createEntity("Player", "player",
    function (go)
        print("Created player: ", go:getName())
    end
)

math.randomseed(os.time())

__state__ = "running"

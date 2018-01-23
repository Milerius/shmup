-- player script

local me = self
local comp = self:getLuaComponent()
local transform = self:getTransformComponent()
local phys = self:getPhysicsComponent()

local SPACE = 57
local LEFT = 71 ; local RIGHT = 72 ; local UP = 73 ; local DOWN = 74

local function collideWith(name)
    print("You lose!")
    __state__ = "gameover"
end

local function laserHit(laser, name)
    if string.find(name, "Laser") then
        return
    end
    removeEntity(laser)
    removeEntity(name)
end

local LASER = "FriendlyLaser"

local function shoot()
    createNoNameEntity(LASER, function (go)
        local box = transform.boundingBox
        local pos = go:getTransformComponent().boundingBox.topLeft
        pos.x = box.topLeft.x + box.size.x
        pos.z = box.topLeft.z
    end)
end

local rotate = {
    on = function(key)
        local ANGLE_MOD = 0.2

        local factors = {}
        factors[LEFT] = 1
        factors[RIGHT] = -1

        comp.meta.rotation = ANGLE_MOD * factors[key]
    end,
    off = function()
        comp.meta.rotation = 0
    end
}

local thrust = {
    on = function() comp.meta.thrust = true end,
    off = function() comp.meta.thrust = false end
}

-- init helpers

local function initCollisions()
    table.insert(collisionHandlers,
        function (name, other)
            if name == me:getName() then
                collideWith(other)
            elseif other == me:getName() then
                collideWith(name)
            end

            if string.find(name, LASER) then
                laserHit(name, other)
            elseif string.find(other, LASER) then
                laserHit(other, name)
            end
        end
    )
end

local function initInput()
    local movement = phys.movement
    phys.speed = 0.3

    -- actions

    local keyFuncs = {}
    keyFuncs[SPACE] = { onPress = shoot }
    keyFuncs[LEFT] = { onPress = rotate.on, onRelease = rotate.off }
    keyFuncs[RIGHT] = { onPress = rotate.on, onRelease = rotate.off }
    keyFuncs[UP] = { onPress = thrust.on, onRelease = thrust.off }

    local function onPress(key)
        local func = keyFuncs[key]
        if func and func.onPress then
            func.onPress(key)
        end
    end

    local function onRelease(key)
        local func = keyFuncs[key]
        if func and func.onRelease then
            func.onRelease(key)
        end
    end

    setKeyHandler(onPress, onRelease)
end

local function initAppearance()
    self:getGraphicsComponent().appearance = "resources/playerShip1_orange.png"
end

-- init

if not comp.meta then
    comp.meta = { rotation = 0 }
    initCollisions()
    initInput()
end

-- main helpers

local function limitBounds()
    local LIMITS = { x = 19, z = 10 }

    local pos = transform.boundingBox.topLeft
    if pos.x < 0 then
        pos.x = 0
    elseif pos.x > LIMITS.x then
        pos.x = LIMITS.x
    end

    if pos.z < 0 then
        pos.z = 0
    elseif pos.z > LIMITS.z then
        pos.z = LIMITS.z
    end
end

local function updateRotation()
    transform.yaw = transform.yaw + comp.meta.rotation
end

local function updateThrust()
    local THRUST = 0.1
    local SLOWDOWN = 0.1

    local function slowDirection(dir)
        local current = phys.movement[dir]
        if current < SLOWDOWN and current > -SLOWDOWN then
            phys.movement[dir] = 0
        else
            phys.movement[dir] = current - current * SLOWDOWN
        end
        print(dir, phys.movement[dir])
    end

    if comp.meta.thrust then
        phys.movement.x = phys.movement.x + math.cos(transform.yaw) * THRUST
        phys.movement.z = phys.movement.z - math.sin(transform.yaw) * THRUST
    else
        slowDirection("x")
        slowDirection("z")
    end
end

-- main

limitBounds()
updateRotation()
updateThrust()

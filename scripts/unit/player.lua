-- player script

local function collideWith(name)
    removeEntity(name)
end

local function shoot()
    print("Shoot!")
end

local me = self
local comp = self:getLuaComponent()

-- init helpers

local function initCollisions()
    table.insert(collisionHandlers,
        function (name, other)
            if name == me:getName() then
                collideWith(other)
            elseif other == me:getName() then
                collideWith(name)
            end
        end
    )
end

local function initInput()
    local phys = self:getPhysicsComponent()
    local movement = phys.movement
    phys.speed = 0.3

    -- actions
    local SPACE = 57
    local keyFuncs = {}
    keyFuncs[SPACE] = {
        onPress = shoot
    }

    -- movement
    local LEFT = 71 ; local RIGHT = 72 ; local UP = 73 ; local DOWN = 74
    local keyMods = {}
    keyMods[LEFT] = { x = -1, z = 0 }
    keyMods[RIGHT] = { x = 1, z = 0 }
    keyMods[UP] = { x = 0, z = -1 }
    keyMods[DOWN] = { x = 0, z = 1 }

    local function onPress(key)
        local func = keyFuncs[key]
        if func and func.onPress then
            func.onPress()
        end

        local mod = keyMods[key]
        if not mod then return end

        if mod.x ~= 0 then
            movement.x = mod.x
        elseif mod.z ~= 0 then
            movement.z = mod.z
        end
    end

    local function onRelease(key)
        local func = keyFuncs[key]
        if func and func.onRelease then
            func.onRelease()
        end

        local mod = keyMods[key]
        if not mod then return end

        if mod.x ~= 0 then
            movement.x = 0
        elseif mod.z ~= 0 then
            movement.z = 0
        end
    end

    setKeyHandler(onPress, onRelease)
end

local function initAppearance()
    self:getGraphicsComponent().appearance = "resources/playerShip1_orange.png"
end

-- init

if not comp.meta then
    comp.meta = {}
    initCollisions()
    initInput()
end

-- main helpers

local function limitBounds()
    local LIMITS = { x = 19, z = 10 }

    local pos = self:getTransformComponent().boundingBox.topLeft
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

-- main

limitBounds()

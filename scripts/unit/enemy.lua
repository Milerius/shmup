-- enemy

local me = self
local comp = self:getLuaComponent()
local transform = self:getTransformComponent()
local phys = self:getPhysicsComponent()

local function laserHit(laser, name)
    if string.find(name, "Laser") then
        return
    end
    removeEntity(laser)
    removeEntity(name)
end

local LASER = "EnemyLaser"

local function shoot()
    createNoNameEntity(LASER, function (go)
        local box = transform.boundingBox
        local pos = go:getTransformComponent().boundingBox.topLeft
        pos.x = box.topLeft.x - box.size.x
        pos.z = box.topLeft.z
    end)
end

-- init

if not __enemy_init__ then
    __enemy_init__ = true

    table.insert(collisionHandlers, function (name, other)
        if string.find(name, LASER) then
            laserHit(name, other)
        elseif string.find(other, LASER) then
            laserHit(other, name)
        end
    end)
end

-- personal init

if not comp.meta then
    comp.meta = {}
    self:attachGraphicsComponent().appearance = "resources/ufoRed.png"

    phys.speed = 1 / 60
    phys.movement.x = -1
end

-- main

local WAIT_TIME = 60
if comp.meta.shootDelay and comp.meta.shootDelay < WAIT_TIME then
    comp.meta.shootDelay = comp.meta.shootDelay + 1
else
    comp.meta.shootDelay = 0
    -- shoot()
end

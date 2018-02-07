-- enemy

local meta = self:getLuaComponent().meta
local transform = self:getTransformComponent()

if not meta.init then
    meta.init = true
    self:getBlasterComponent().shootDelay = 20

    local target = getEntity(meta.target)
    local targetPos = target:getTransformComponent().boundingBox.topLeft
    transform.yaw = transform.boundingBox.topLeft:angleToXZ(targetPos)
end

-- helper

local function normalizeRadian(rad)
    rad = math.fmod(rad, math.pi * 2)
    if rad < 0 then
        rad = rad + math.pi * 2
    end
    return rad
end

-- main

if not hasEntity(meta.target) then
    return
end

local target = getEntity(meta.target):getTransformComponent().boundingBox.topLeft
local pos = transform.boundingBox.topLeft
local angle = normalizeRadian(pos:angleToXZ(target))
local yaw = normalizeRadian(transform.yaw)
local angleDiff = math.abs(angle - yaw)

local THRUST_THRESHOLD = math.pi / 64
local TURN_THRESHOLD = math.pi / 128
local FIRE_THRESHOLD = math.pi / 128

local function adjustThrust()
    local thrust = self:getThrustComponent()

    if angleDiff < THRUST_THRESHOLD then
        thrust.on = true
    else
        thrust.on = false
    end
end

local function adjustTurn()
    local rotation = self:getRotationComponent()

    if angleDiff < TURN_THRESHOLD then
        rotation.rotation = 0
        return
    end

    if angle < yaw then
        rotation.rotation = -1
    else
        rotation.rotation = 1
    end

    if angleDiff > math.pi then
        rotation.rotation = -rotation.rotation
    end
end

local function fire()
    local blaster = self:getBlasterComponent()

    if angleDiff < FIRE_THRESHOLD then
        blaster.firing = true
    else
        blaster.firing = false
    end
end

adjustThrust()
adjustTurn()
fire()

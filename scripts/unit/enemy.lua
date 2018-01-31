-- enemy

local meta = self:getLuaComponent().meta
local transform = self:getTransformComponent()

if not meta.init then
    meta.init = true
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

local target = getEntity(meta.target):getTransformComponent().boundingBox.topLeft
local pos = transform.boundingBox.topLeft
local angle = normalizeRadian(pos:angleToXZ(target))
local yaw = normalizeRadian(transform.yaw)

local thrust = self:getThrustComponent()
local rotation = self:getRotationComponent()

local THRUST_THRESHOLD = math.pi / 64
local TURN_THRESHOLD = math.pi / 128

local function adjustThrust()
    if math.abs(angle - yaw) < THRUST_THRESHOLD then
        thrust.on = true
    else
        thrust.on = false
    end
end

local function adjustTurn()
    if math.abs(angle - yaw) < TURN_THRESHOLD then
        rotation.rotation = 0
    else
        if angle < yaw then
            rotation.rotation = -1
        else
            rotation.rotation = 1
        end

        if math.abs(angle - yaw) > math.pi then
            rotation.rotation = -rotation.rotation
        end
    end
end

adjustThrust()
adjustTurn()

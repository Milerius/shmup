-- clean

if not __state__ or __state__ ~= "running" then
    return
end

if not hasEntity("player") then
    return
end

local THRESHOLD = 20
local playerPos = getEntity("player"):getTransformComponent().boundingBox.topLeft

local function remove(go)
    if go:hasLuaComponent() then
        local meta = go:getLuaComponent().meta
        if meta and meta.noCleanup then
            return
        end
    end

    local pos = go:getTransformComponent().boundingBox.topLeft
    if pos:distanceTo(playerPos) > THRESHOLD then
        removeEntity(go)
    end
end

for i, go in ipairs(getGameObjectsWithPhysicsComponent()) do
    remove(go)
end
-- clean

if not __state__ or __state__ ~= "running" then
    return
end

local BOUNDS = { x = 20, z = 11.25 }

local function remove(go)
    if go:hasLuaComponent() then
        local meta = go:getLuaComponent().meta
        if meta and meta.noCleanup then
            return
        end
    end

    local box = go:getTransformComponent().boundingBox
    if box.topLeft.x - BOUNDS.x > 2 * box.size.x or
            box.topLeft.x < -2 * box.size.x or
            box.topLeft.z - BOUNDS.z > 2 * box.size.z or
            box.topLeft.z < -2 * box.size.z then
        removeEntity(go:getName())
    end
end

for i, go in ipairs(getGameObjectsWithTransformComponent()) do
    remove(go)
end
-- clean

if not __state__ or __state__ ~= "running" then
    return
end

local BOUNDS = { x = 20, z = 11.25 }

for i, go in ipairs(getGameObjectsWithTransformComponent()) do
    local box = go:getTransformComponent().boundingBox
    if box.topLeft.x - BOUNDS.x > 2 * box.size.x or
            box.topLeft.x < -2 * box.size.x or
            box.topLeft.z - BOUNDS.z > 2 * box.size.z or
            box.topLeft.z < -2 * box.size.z then
        removeEntity(go:getName())
    end
end
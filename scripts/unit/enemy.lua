-- enemy

local LIMIT = 10

local pos = self:getTransformComponent().boundingBox.topLeft
if pos.z > LIMIT then
    print("Removing ", self:getName())
    removeEntity(self:getName())
end
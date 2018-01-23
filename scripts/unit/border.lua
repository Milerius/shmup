-- border

local pos = self:getTransformComponent().boundingBox.topLeft
local size = self:getTransformComponent().boundingBox.size

local target = getEntity(self:getLuaComponent().meta.target)
local targetPos = target:getTransformComponent().boundingBox.topLeft
local targetSize = target:getTransformComponent().boundingBox.size

pos.x = targetPos.x
pos.z = targetPos.z
pos.y = 1

size.x = targetSize.x
size.z = targetSize.z

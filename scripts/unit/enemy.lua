-- enemy

local comp = self:getLuaComponent()
if not comp.meta then
    comp.meta = {}
    self:attachGraphicsComponent().appearance = "resources/ufoRed.png"

    local phys = self:getPhysicsComponent()
    phys.speed = 1 / 60
    phys.movement.x = -1
end

local pos = self:getTransformComponent().boundingBox.topLeft
if pos.x < -1 then
    removeEntity(self:getName())
end

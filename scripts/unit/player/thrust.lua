-- player.thrust

local SPEED = 0.3
local THRUST = 0.1
local SLOWDOWN = 0.1

local meta = self:getLuaComponent().meta
local transform = self:getTransformComponent()
local phys = self:getPhysicsComponent()

thrust = {
    on = function() meta.thrust = true end,
    off = function() meta.thrust = false end,
    draw = function()
        local t = getEntity("thrust"):getTransformComponent()
        t.yaw = transform.yaw

        local pos = t.boundingBox.topLeft
        local mePos = transform.boundingBox.topLeft
        local meSize = transform.boundingBox.size

        pos.x = mePos.x + meSize.x / 2 - math.cos(transform.yaw)
        pos.z = mePos.z + meSize.z / 2 + math.sin(transform.yaw)
    end,
    undraw = function()
        local box = getEntity("thrust"):getTransformComponent().boundingBox
        box.topLeft.x = -box.size.x
        box.topLeft.z = -box.size.z
    end
}

table.insert(player.init, function()
    phys.speed = SPEED

    createEntity("GameObject", "thrust", function (go)
        local box = go:attachTransformComponent().boundingBox
        box.size.x = 0.5 ; box.size.z = 0.5
        box.topLeft.x = -box.size.x
        box.topLeft.z = -box.size.z
        box.topLeft.y = 1

        local graphics = go:attachGraphicsComponent()
        graphics.appearance = "resources/Effects/fire16.png"
        graphics.yaw = math.pi / 2
    end)
end)

table.insert(player.update, function()
    local function slowDirection(dir)
        local current = phys.movement[dir]
        if current < SLOWDOWN and current > -SLOWDOWN then
            phys.movement[dir] = 0
        else
            phys.movement[dir] = current - current * SLOWDOWN
        end
    end

    if meta.thrust then
        phys.movement.x = phys.movement.x + math.cos(transform.yaw) * THRUST
        phys.movement.z = phys.movement.z - math.sin(transform.yaw) * THRUST
        thrust.draw()
    else
        slowDirection("x") ; slowDirection("z")
        thrust.undraw()
    end
end)

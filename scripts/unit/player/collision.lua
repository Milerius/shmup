-- player.collision

local me = self
local LASER = "player"

table.insert(player.init, function()
    table.insert(collisionHandlers,
        function (name, other)
            if name == me:getName() then
                collideWith(other)
            elseif other == me:getName() then
                collideWith(name)
            end

            local go = getEntity(name)
            if go:hasLaserComponent() and go:getLaserComponent().type == LASER then
                laserHit(name, other)
            else
                local go = getEntity(other)
                if go:hasLaserComponent() and go:getLaserComponent().type == LASER then
                    laserHit(other, name)
                end
            end
        end
    )
end)


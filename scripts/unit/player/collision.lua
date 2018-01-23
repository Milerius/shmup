-- player.collision

local me = self
local LASER = "FriendlyLaser"

table.insert(player.init, function()
    table.insert(collisionHandlers,
        function (name, other)
            if name == me:getName() then
                collideWith(other)
            elseif other == me:getName() then
                collideWith(name)
            end

            if string.find(name, LASER) then
                laserHit(name, other)
            elseif string.find(other, LASER) then
                laserHit(other, name)
            end
        end
    )
end)


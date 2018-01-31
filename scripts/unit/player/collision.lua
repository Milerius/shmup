-- player.collision

table.insert(player.init, function()
    table.insert(collisionHandlers,
        function (name, other)
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


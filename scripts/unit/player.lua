-- player script

local me = self

if not __player_init__ then
    table.insert(collisionHandlers,
        function (name, other)
            if name == me:getName() then
                collideWith(other)
            elseif other == me:getName() then
                collideWith(name)
            end
        end
    )
    __player_init__ = true
end

function collideWith(name)
    print("Player colliding with ", name)
end

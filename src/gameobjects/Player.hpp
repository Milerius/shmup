#pragma once

#include "common/components/GraphicsComponent.hpp"
#include "common/components/LuaComponent.hpp"
#include "common/gameobjects/KinematicObject.hpp"

class Player : public kengine::KinematicObject {
public:
    Player(std::string_view name) : KinematicObject(name) {
        auto & lua = attachComponent<kengine::LuaComponent>();
        lua.attachScript("scripts/unit/player.lua");

        attachComponent<kengine::GraphicsComponent>("resources/ship.png");
    }

    pmeta_get_class_name(Player);
};
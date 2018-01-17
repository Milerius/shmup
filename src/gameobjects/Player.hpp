#pragma once

#include "common/components/GraphicsComponent.hpp"
#include "common/components/LuaComponent.hpp"
#include "common/gameobjects/KinematicObject.hpp"

class Player : public kengine::KinematicObject {
public:
    Player(std::string_view name) : KinematicObject(name) {
        auto & lua = attachComponent<kengine::LuaComponent>();
        lua.attachScript("scripts/unit/player.lua");
        attachComponent<kengine::GraphicsComponent>("resources/playerShip1_orange.png");

        getComponent<kengine::TransformComponent3d>().boundingBox.topLeft.y = 1;
    }

    pmeta_get_class_name(Player);
};
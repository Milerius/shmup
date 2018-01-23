#pragma once

#include "common/components/GraphicsComponent.hpp"
#include "common/components/LuaComponent.hpp"
#include "common/gameobjects/KinematicObject.hpp"

class Player : public kengine::KinematicObject {
public:
    Player(std::string_view name) : KinematicObject(name) {
        auto & lua = attachComponent<kengine::LuaComponent>();
        lua.attachScript("scripts/unit/player.lua");

        auto & transform = getComponent<kengine::TransformComponent3d>();
        transform.boundingBox.topLeft.y = 2;

        auto & graphics = attachComponent<kengine::GraphicsComponent>("resources/playerShip1_orange.png");
        graphics.yaw = -M_PI_2;
    }

    pmeta_get_class_name(Player);
};
#pragma once

#include "common/components/GraphicsComponent.hpp"
#include "common/components/LuaComponent.hpp"
#include "common/gameobjects/KinematicObject.hpp"
#include "components/ThrustComponent.hpp"
#include "components/BlasterComponent.hpp"
#include "components/RotationComponent.hpp"

class Player : public kengine::KinematicObject {
public:
    Player(std::string_view name) : KinematicObject(name) {
        getComponent<kengine::PhysicsComponent>().speed = 0.1;

        auto & transform = getComponent<kengine::TransformComponent3d>();
        transform.boundingBox.topLeft.y = 2;

        attachComponent<ThrustComponent>();
        attachComponent<BlasterComponent>();
        attachComponent<RotationComponent>();

        auto & lua = attachComponent<kengine::LuaComponent>();
        lua.attachScript("scripts/unit/player.lua");

        auto & graphics = attachComponent<kengine::GraphicsComponent>("resources/playerShip1_orange.png");
        graphics.yaw = -M_PI_2;
    }

    pmeta_get_class_name(Player);
};
#pragma once

#include <cmath>
#ifndef M_PI
# define M_PI 3.14159265358979323846264338327950288
#endif
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
        getComponent<kengine::TransformComponent3d>().boundingBox.topLeft.y = 2;

        attachComponent<ThrustComponent>();
        attachComponent<BlasterComponent>().shootDelay = 10;
        attachComponent<RotationComponent>().rotationSpeed = 0.075;

        auto & lua = attachComponent<kengine::LuaComponent>();
        lua.attachScript("scripts/unit/player.lua");

        auto & graphics = attachComponent<kengine::GraphicsComponent>("resources/playerShip1_orange.png");
        graphics.yaw = -M_PI / 2;
    }

    pmeta_get_class_name(Player);
};
#pragma once

#include "gameobjects/KinematicObject.hpp"
#include "components/LuaComponent.hpp"
#include "components/GraphicsComponent.hpp"
#include "components/ThrustComponent.hpp"
#include "components/BlasterComponent.hpp"

class Enemy : public kengine::KinematicObject {
public:
    Enemy(std::string_view name) : KinematicObject(name) {
        getComponent<kengine::PhysicsComponent>().speed = 1.0 / 60.0;
        getComponent<kengine::TransformComponent3d>().boundingBox.topLeft.y = 2;

        attachComponent<ThrustComponent>();
        attachComponent<RotationComponent>();

        auto & lua = attachComponent<kengine::LuaComponent>();
        lua.attachScript("scripts/unit/enemy.lua");

        auto & graphics = attachComponent<kengine::GraphicsComponent>("resources/Enemies/enemyBlack1.png");
        graphics.yaw = M_PI_2;
    }

    pmeta_get_class_name(Enemy);
};
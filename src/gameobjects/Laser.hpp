#pragma once

#include "common/gameobjects/KinematicObject.hpp"
#include "common/components/GraphicsComponent.hpp"

class FriendlyLaser : public kengine::KinematicObject {
public:
    FriendlyLaser(std::string_view name) : KinematicObject(name) {
        auto & transform = getComponent<kengine::TransformComponent3d>();
        transform.boundingBox.size.x = 0.2;
        transform.boundingBox.topLeft.y = 2;

        auto & phys = getComponent<kengine::PhysicsComponent>();
        phys.speed = 0.2;

        auto & graphics = attachComponent<kengine::GraphicsComponent>("resources/Lasers/laserBlue01.png");
        graphics.yaw = -M_PI_2;
    }

    pmeta_get_class_name(FriendlyLaser);
};

class EnemyLaser : public kengine::KinematicObject {
public:
    EnemyLaser(std::string_view name) : KinematicObject(name) {
        auto & transform = getComponent<kengine::TransformComponent3d>();
        transform.boundingBox.size.x = 0.2;
        transform.boundingBox.topLeft.y = 2;

        auto & phys = getComponent<kengine::PhysicsComponent>();
        phys.speed = 0.2;

        auto & graphics = attachComponent<kengine::GraphicsComponent>("resources/Lasers/laserRed01.png");
        graphics.yaw = -M_PI_2;
    }

    pmeta_get_class_name(EnemyLaser);
};
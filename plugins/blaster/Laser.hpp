#pragma once

#include "common/gameobjects/KinematicObject.hpp"
#include "common/components/GraphicsComponent.hpp"
#include "components/LaserComponent.hpp"

class Laser : public kengine::KinematicObject {
public:
    Laser(std::string_view name) : KinematicObject(name) {
        attachComponent<LaserComponent>();

        auto & transform = getComponent<kengine::TransformComponent3d>();
        transform.boundingBox.size.x = 0.2;
        transform.boundingBox.topLeft.y = 2;

        auto & phys = getComponent<kengine::PhysicsComponent>();
        phys.speed = 0.2;

        auto & graphics = attachComponent<kengine::GraphicsComponent>("resources/Lasers/laserRed01.png");
        graphics.yaw = -M_PI_2;
    }

    pmeta_get_class_name(Laser);
};

#pragma once

#include "GameObject.hpp"
#include "common/components/TransformComponent.hpp"
#include "common/components/GraphicsComponent.hpp"

class Thrust : public kengine::GameObject {
public:
    Thrust(std::string_view name) : GameObject(name) {
        auto & box = attachComponent<kengine::TransformComponent3d>().boundingBox;
        box.size.x = 0.2 ; box.size.z = 0.5;
        box.topLeft.x = -box.size.x;
        box.topLeft.z = -box.size.z;
        box.topLeft.y = 1;

        auto & graphics = attachComponent<kengine::GraphicsComponent>();
        graphics.appearance = "resources/Effects/fire16.png";
        graphics.yaw = -M_PI_2;
    }

    pmeta_get_class_name(Thrust);
};
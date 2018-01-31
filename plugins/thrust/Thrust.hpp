#pragma once

#include <cmath>
#ifndef M_PI
# define M_PI 3.14159265358979323846264338327950288
#endif
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
        graphics.yaw = -M_PI / 2;
    }

    pmeta_get_class_name(Thrust);
};
#pragma once

#include "common/gameobjects/KinematicObject.hpp"
#include "common/components/LuaComponent.hpp"
#include "common/components/GraphicsComponent.hpp"

class Enemy : public kengine::KinematicObject {
public:
    Enemy(std::string_view name) : KinematicObject(name) {
        getComponent<kengine::TransformComponent3d>().boundingBox.topLeft.y = 2;

        auto & lua = attachComponent<kengine::LuaComponent>();
        lua.attachScript("scripts/unit/enemy.lua");

        auto & graphics = attachComponent<kengine::GraphicsComponent>("resources/Enemies/enemyBlack1.png");
        graphics.yaw = -M_PI_2;
    }

    pmeta_get_class_name(Enemy);
};
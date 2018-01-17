#pragma once

#include "common/gameobjects/KinematicObject.hpp"
#include "common/components/LuaComponent.hpp"
#include "common/components/GraphicsComponent.hpp"

class Enemy : public kengine::KinematicObject {
public:
    Enemy(std::string_view name) : KinematicObject(name) {
        auto & lua = attachComponent<kengine::LuaComponent>();
        lua.attachScript("scripts/unit/enemy.lua");

        attachComponent<kengine::GraphicsComponent>("resources/ufoRed.png");
        getComponent<kengine::TransformComponent3d>().boundingBox.topLeft.y = 1;
    }

    pmeta_get_class_name(Enemy);
};
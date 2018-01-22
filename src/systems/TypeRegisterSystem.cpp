#include "TypeRegisterSystem.hpp"
#include "EntityManager.hpp"

#include "common/systems/LuaSystem.hpp"

#include "common/gameobjects/Text.hpp"
#include "common/gameobjects/KinematicObject.hpp"
#include "common/components/GraphicsComponent.hpp"
#include "common/components/CameraComponent.hpp"
#include "gameobjects/Player.hpp"
#include "gameobjects/Enemy.hpp"

TypeRegisterSystem::TypeRegisterSystem(kengine::EntityManager & em) {
    em.registerTypes<kengine::LuaSystem,
            kengine::LuaComponent,
            kengine::TransformComponent3d, putils::Rect3d, putils::Point3d,
            kengine::PhysicsComponent, kengine::GraphicsComponent, kengine::CameraComponent3d,
            kengine::Text, kengine::KinematicObject,
            Player, Enemy
    >();
}
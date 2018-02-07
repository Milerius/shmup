#include "TypeRegisterSystem.hpp"
#include "EntityManager.hpp"

#include "systems/LuaSystem.hpp"
#include "systems/PySystem.hpp"

#include "gameobjects/Text.hpp"
#include "gameobjects/KinematicObject.hpp"
#include "components/GraphicsComponent.hpp"
#include "components/CameraComponent.hpp"
#include "components/InputComponent.hpp"
#include "gameobjects/Player.hpp"
#include "gameobjects/Enemy.hpp"

template<typename ...Types>
static void registerTypes(kengine::EntityManager & em) {
    em.registerTypes<kengine::LuaSystem, Types...>();
    em.registerTypes<kengine::PySystem, Types...>();
}

TypeRegisterSystem::TypeRegisterSystem(kengine::EntityManager & em) {
    registerTypes<
            kengine::LuaComponent, kengine::PyComponent,
            kengine::TransformComponent3d, putils::Rect3d, putils::Point3d,
            kengine::PhysicsComponent, kengine::GraphicsComponent, kengine::CameraComponent3d,
            kengine::GUIComponent, kengine::InputComponent,
            kengine::Text, kengine::KinematicObject,
            Player, Enemy
    >(em);
}
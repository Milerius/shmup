#include "TypeRegisterSystem.hpp"
#include "EntityManager.hpp"

#include "systems/LuaSystem.hpp"

#include "gameobjects/Text.hpp"
#include "gameobjects/KinematicObject.hpp"
#include "components/GraphicsComponent.hpp"
#include "components/CameraComponent.hpp"
#include "components/InputComponent.hpp"
#include "gameobjects/Player.hpp"
#include "gameobjects/Enemy.hpp"

TypeRegisterSystem::TypeRegisterSystem(kengine::EntityManager & em) {
    em.registerTypes<kengine::LuaSystem,
            kengine::LuaComponent,
            kengine::TransformComponent3d, putils::Rect3d, putils::Point3d,
            kengine::PhysicsComponent, kengine::GraphicsComponent, kengine::CameraComponent3d,
            kengine::GUIComponent, kengine::InputComponent,
            kengine::Text, kengine::KinematicObject,
            Player, Enemy
    >();
}
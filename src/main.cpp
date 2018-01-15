#include "EntityManager.hpp"

#include "common/systems/LuaSystem.hpp"
#include "common/gameobjects/Text.hpp"
#include "common/components/PhysicsComponent.hpp"
#include "common/components/GraphicsComponent.hpp"

int main() {
    kengine::EntityManager em;

    em.loadSystems<kengine::LuaSystem>();
    em.registerTypes<kengine::LuaSystem,
            kengine::LuaComponent, kengine::Text,
            kengine::TransformComponent3d, kengine::PhysicsComponent,
            kengine::GraphicsComponent
    >();

    while (em.running)
        em.execute();
}

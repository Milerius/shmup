#include "go_to_bin_dir.hpp"

#include "common/systems/PhysicsSystem.hpp"
#include "common/systems/LuaSystem.hpp"
#include "common/systems/LuaCollisionSystem.hpp"
#include "common/gameobjects/Text.hpp"
#include "gameobjects/Player.hpp"
#include "gameobjects/Enemy.hpp"

int main(int, char **av) {
    putils::goToBinDir(av[0]);

    kengine::EntityManager em;

    em.loadSystems<kengine::LuaSystem, kengine::LuaCollisionSystem, kengine::PhysicsSystem>("plugins");
    em.registerTypes<kengine::LuaSystem,
            kengine::LuaComponent,
            kengine::TransformComponent3d, putils::Rect3d, putils::Point3d,
            kengine::PhysicsComponent,
            kengine::GraphicsComponent,
            kengine::Text, Player, Enemy
    >();

    while (em.running)
        em.execute();
}

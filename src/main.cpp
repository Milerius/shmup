#include "go_to_bin_dir.hpp"

#include "common/systems/PhysicsSystem.hpp"
#include "common/systems/LuaSystem.hpp"
#include "common/systems/LuaCollisionSystem.hpp"

#include "systems/TypeRegisterSystem.hpp"

int main(int, char **av) {
    putils::goToBinDir(av[0]);

    kengine::EntityManager em;

    em.loadSystems<
            kengine::LuaSystem, kengine::LuaCollisionSystem,
            kengine::PhysicsSystem, TypeRegisterSystem
    >("plugins");

    while (em.running)
        em.execute();
}

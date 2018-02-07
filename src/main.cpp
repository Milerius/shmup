#include "go_to_bin_dir.hpp"

#include "systems/PhysicsSystem.hpp"
#include "systems/PySystem.hpp"
#include "systems/LuaSystem.hpp"
#include "systems/LuaCollisionSystem.hpp"

#include "systems/TypeRegisterSystem.hpp"

int main(int, char **av) {
    putils::goToBinDir(av[0]);

    kengine::EntityManager em;

    em.loadSystems<
            kengine::LuaSystem, kengine::LuaCollisionSystem,
            kengine::PySystem,
            kengine::PhysicsSystem, TypeRegisterSystem
    >("plugins");
    em.removeSystem<TypeRegisterSystem>();

    while (em.running)
        em.execute();
}

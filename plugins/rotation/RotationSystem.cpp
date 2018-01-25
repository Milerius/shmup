#include "RotationSystem.hpp"
#include "EntityManager.hpp"
#include "systems/LuaSystem.hpp"
#include "components/RotationComponent.hpp"
#include "components/TransformComponent.hpp"

EXPORT kengine::ISystem * getSystem(kengine::EntityManager & em) {
    return new RotationSystem(em);
}

RotationSystem::RotationSystem(kengine::EntityManager & em) : _em(em) {
    _em.registerTypes<kengine::LuaSystem, RotationComponent>();
}

void RotationSystem::execute() noexcept {
    const auto frames = time.getDeltaFrames();

    for (const auto go : _em.getGameObjects<RotationComponent>()) {
        auto & transform = go->getComponent<kengine::TransformComponent3d>();
        auto & rotation = go->getComponent<RotationComponent>();
        transform.yaw += rotation.rotation * rotation.rotationSpeed * frames;
    }
}

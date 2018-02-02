#include <cmath>

#include "ThrustSystem.hpp"

#include "EntityManager.hpp"
#include "common/systems/LuaSystem.hpp"

#include "Thrust.hpp"
#include "components/ThrustComponent.hpp"
#include "common/components/PhysicsComponent.hpp"

EXPORT kengine::ISystem * getSystem(kengine::EntityManager & em) {
    return new ThrustSystem(em);
}

ThrustSystem::ThrustSystem(kengine::EntityManager & em) : _em(em) {
    _em.registerTypes<kengine::LuaSystem, ThrustComponent>();
}

template<typename T>
static void slowDirection(T dir, kengine::PhysicsComponent & phys, const ThrustComponent & comp) {
    const auto current = phys.movement.*dir;
    if (current < comp.slowdown && current > -comp.slowdown)
        phys.movement.*dir = 0;
    else
        phys.movement.*dir = current - current * comp.slowdown;
}

void ThrustSystem::execute() noexcept {
    for (const auto go : _em.getGameObjects<ThrustComponent>()) {
        const auto & comp = go->getComponent<ThrustComponent>();
        auto & phys = go->getComponent<kengine::PhysicsComponent>();

        if (comp.on) {
            auto & transform = go->getComponent<kengine::TransformComponent3d>();
            phys.movement.x = phys.movement.x + std::cos(transform.yaw) * comp.thrust;
            phys.movement.z = phys.movement.z - std::sin(transform.yaw) * comp.thrust;
            drawThrust(*go);
        } else {
            slowDirection(&putils::Point3d::x, phys, comp);
            hideThrust(*go);
        }
    }
}

static std::string getThrustName(kengine::GameObject & go) noexcept {
    return putils::concat("thrust", go.getName());
}

void ThrustSystem::drawThrust(kengine::GameObject & go) noexcept {
    const auto name = getThrustName(go);

    if (!_em.hasEntity(name))
        _em.createEntity<Thrust>(name);

    auto & thrust = _em.getEntity(name);
    auto & goTransform = go.getComponent<kengine::TransformComponent3d>();
    auto & thrustTransform = thrust.getComponent<kengine::TransformComponent3d>();

    thrustTransform.yaw = goTransform.yaw;

    auto & thrustPos = thrustTransform.boundingBox.topLeft;
    auto & thrustSize = thrustTransform.boundingBox.size;
    auto & goPos = goTransform.boundingBox.topLeft;
    auto & goSize = goTransform.boundingBox.size;

    thrustPos.x = goPos.x + (goSize.x / 2) - (thrustSize.x / 2) - std::cos(goTransform.yaw) * 0.9;
    thrustPos.z = goPos.z + (goSize.z / 2) - (thrustSize.z / 2) + std::sin(goTransform.yaw) * 0.9;
    thrustPos.y = 2;
}

void ThrustSystem::hideThrust(kengine::GameObject & go) noexcept {
    const auto name = getThrustName(go);

    if (!_em.hasEntity(name))
        return;

    auto & thrust = _em.getEntity(name);
    auto & box = thrust.getComponent<kengine::TransformComponent3d>().boundingBox;
    box.topLeft.y = 0;
}

void ThrustSystem::handle(const kengine::packets::RemoveGameObject & p) noexcept {
    const auto name = getThrustName(p.go);

    if (!_em.hasEntity(name))
        return;
    _em.removeEntity(name);
}

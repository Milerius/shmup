#include "BlasterSystem.hpp"
#include "EntityManager.hpp"
#include "common/systems/LuaSystem.hpp"

#include "components/BlasterComponent.hpp"
#include "Laser.hpp"

EXPORT kengine::ISystem * getSystem(kengine::EntityManager & em) {
    return new BlasterSystem(em);
}

BlasterSystem::BlasterSystem(kengine::EntityManager & em) : _em(em) {
    _em.registerTypes<kengine::LuaSystem, BlasterComponent, LaserComponent>();
}

void BlasterSystem::execute() noexcept {
    for (const auto go : _em.getGameObjects<BlasterComponent>()) {
        auto & comp = go->getComponent<BlasterComponent>();

        if (comp.firing) {
            if (comp.currDelay >= comp.shootDelay) {
                fire(*go, comp);
                comp.currDelay -= comp.shootDelay;
            }

            comp.currDelay += time.getDeltaFrames();
        } else
            comp.currDelay = comp.shootDelay;
    }
}

void BlasterSystem::fire(const kengine::GameObject & go, const BlasterComponent & comp) noexcept {
    _em.createEntity<Laser>([&go, &comp](kengine::GameObject & laser) {
        laser.getComponent<LaserComponent>().type = comp.type;

        auto & transform = go.getComponent<kengine::TransformComponent3d>();
        auto & laserTransform = laser.getComponent<kengine::TransformComponent3d>();
        laserTransform.yaw = transform.yaw;

        auto & box = transform.boundingBox;
        auto & laserBox = laserTransform.boundingBox;
        auto & pos = laserBox.topLeft;
        auto & size = laserBox.size;

        pos.x = box.topLeft.x + (box.size.x / 2) - (size.x / 2) + std::cos(transform.yaw);
        pos.z = box.topLeft.z + (box.size.z / 2) - (size.z / 2) - std::sin(transform.yaw);

        auto & movement = laser.getComponent<kengine::PhysicsComponent>().movement;
        movement.x = std::cos(transform.yaw);
        movement.z = -std::sin(transform.yaw);
    });
}
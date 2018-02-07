#include "CameraSystem.hpp"
#include "EntityManager.hpp"
#include "systems/LuaSystem.hpp"
#include "components/CameraComponent.hpp"
#include "components/TransformComponent.hpp"

EXPORT kengine::ISystem * getSystem(kengine::EntityManager & em) {
    return new CameraSystem(em);
}

CameraSystem::CameraSystem(kengine::EntityManager & em)
        : _em(em),
          _camera(_em.createEntity<kengine::GameObject>("camera", [](kengine::GameObject & go) {
              auto & frustrum = go.attachComponent<kengine::CameraComponent3d>().frustrum;
              frustrum.topLeft = { 0, 0, 0 };
              frustrum.size = { 20, 0, 11.25 };

              go.attachComponent<kengine::TransformComponent3d>();
          }))
{}

static const auto factor = 2;

void CameraSystem::execute() noexcept {
    if (!_em.hasEntity("player"))
        return;

    const auto & playerPos = _em.getEntity("player").getComponent<kengine::TransformComponent3d>().boundingBox.topLeft;

    auto & frustrum = _camera.getComponent<kengine::CameraComponent3d>().frustrum;
    auto & pos = frustrum.topLeft;
    const auto & size = frustrum.size;
    const putils::Point3d dest{ playerPos.x - size.x / 2, 0, playerPos.z - size.z / 2 };
    const putils::Point3d dist{ dest.x - pos.x, 0, dest.z - pos.z };
    pos.x += dist.x / factor;
    pos.z += dist.z / factor;
}

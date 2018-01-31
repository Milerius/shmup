#include <common/components/CameraComponent.hpp>
#include "GUISystem.hpp"
#include "EntityManager.hpp"
#include "systems/LuaSystem.hpp"
#include "gameobjects/Text.hpp"

EXPORT kengine::ISystem * getSystem(kengine::EntityManager & em) {
    return new GUISystem(em);
}

static const std::string font = "resources/font.ttf";
static void initGUIElement(kengine::GameObject & go) {
    auto & gui = go.getComponent<kengine::GUIComponent>();
    gui.font = font;
    gui.topLeft.y = 10;
}

GUISystem::GUISystem(kengine::EntityManager & em)
        : _em(em),
          _fps(_em.createEntity<kengine::Text>("fps", initGUIElement)),
          _score(_em.createEntity<kengine::Text>("score", [](kengine::GameObject & go) {
              initGUIElement(go);
              go.getComponent<kengine::GUIComponent>().topLeft.x = 0.9;
          }))
{}

void GUISystem::execute() noexcept {
    updateFPS();

    if (_em.hasEntity("camera")) {
        auto & cam = _em.getEntity("camera");
        for (const auto go : _em.getGameObjects<kengine::GUIComponent>())
            go->getComponent<kengine::GUIComponent>().camera = &cam;
    } else {
        for (const auto go : _em.getGameObjects<kengine::GUIComponent>())
            go->getComponent<kengine::GUIComponent>().camera = nullptr;
    }
}

void GUISystem::updateFPS() noexcept {
    static int frames = 0;
    static double t = 0;

    ++frames;
    t += time.getDeltaFrames();
    if (t > getFrameRate()) {
        t -= getFrameRate();
        _fps.getComponent<kengine::GUIComponent>().text = putils::concat("FPS: ", frames / 2);
        frames = 0;
    }
}

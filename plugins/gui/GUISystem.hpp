#pragma once

#include "System.hpp"

class GUISystem : public kengine::System<GUISystem> {
public:
    GUISystem(kengine::EntityManager & em);

public:
    void execute() noexcept override;
    std::size_t getFrameRate() const noexcept final { return 120; }

public:
    void updateFPS() noexcept;

private:
    kengine::EntityManager & _em;
    kengine::GameObject & _fps;
    kengine::GameObject & _score;
};
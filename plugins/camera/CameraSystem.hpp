#pragma once

#include "System.hpp"

class CameraSystem : public kengine::System<CameraSystem> {
public:
    CameraSystem(kengine::EntityManager & em);

public:
    void execute() noexcept override;
    std::size_t getFrameRate() const noexcept override { return 120; }

private:
    kengine::EntityManager & _em;
    kengine::GameObject & _camera;
    // kengine::GameObject & _minimap;
};
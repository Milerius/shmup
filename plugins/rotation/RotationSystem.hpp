#pragma once

#include "System.hpp"

class RotationSystem : public kengine::System<RotationSystem> {
public:
    RotationSystem(kengine::EntityManager & em);

public:
    void execute() noexcept override;

private:
    kengine::EntityManager & _em;
};
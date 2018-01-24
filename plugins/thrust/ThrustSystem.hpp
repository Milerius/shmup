#pragma once

#include "Point.hpp"
#include "System.hpp"

class ThrustSystem : public kengine::System<ThrustSystem, kengine::packets::RemoveGameObject> {
public:
    ThrustSystem(kengine::EntityManager & em);

public:
    void execute() noexcept override;

public:
    void handle(const kengine::packets::RemoveGameObject & p) noexcept;

private:
    void drawThrust(kengine::GameObject & go) noexcept;
    void hideThrust(kengine::GameObject & go) noexcept;

private:
    kengine::EntityManager & _em;
};
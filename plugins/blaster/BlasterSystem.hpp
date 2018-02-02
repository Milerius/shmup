#pragma once

#include "System.hpp"
#include "packets/Collision.hpp"

class BlasterComponent;

class BlasterSystem : public kengine::System<BlasterSystem, kengine::packets::Collision> {
public:
    BlasterSystem(kengine::EntityManager & em);

public:
    void execute() noexcept override;
    void handle(const kengine::packets::Collision & p) noexcept;

private:
    void fire(const kengine::GameObject & go, const BlasterComponent & comp) noexcept;
    void checkCollision(kengine::GameObject & go, kengine::GameObject & other) noexcept;

private:
    kengine::EntityManager & _em;
};
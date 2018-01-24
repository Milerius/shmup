#pragma once

#include "System.hpp"

class BlasterComponent;

class BlasterSystem : public kengine::System<BlasterSystem> {
public:
    BlasterSystem(kengine::EntityManager & em);

public:
    void execute() noexcept override;

private:
    void fire(const kengine::GameObject & go, const BlasterComponent & comp) noexcept;

private:
    kengine::EntityManager & _em;
};
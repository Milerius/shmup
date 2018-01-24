#pragma once

#include "SerializableComponent.hpp"

class ThrustComponent : public kengine::SerializableComponent<ThrustComponent> {
public:
    ThrustComponent() = default;

    double thrust = 0.1;
    double slowdown = 0.01;
    bool on = false;

public:
    pmeta_get_class_name(ThrustComponent);

    pmeta_get_attributes(
        pmeta_reflectible_attribute(&ThrustComponent::thrust),
        pmeta_reflectible_attribute(&ThrustComponent::slowdown),
        pmeta_reflectible_attribute(&ThrustComponent::on)
    );
};
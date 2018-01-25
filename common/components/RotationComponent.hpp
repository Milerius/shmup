#pragma once

#include "SerializableComponent.hpp"

struct RotationComponent : public kengine::SerializableComponent<RotationComponent> {
    double rotationSpeed = 0.05;
    double rotation = 0;

    pmeta_get_class_name(RotationComponent);

    pmeta_get_attributes(
            pmeta_reflectible_attribute(&RotationComponent::rotationSpeed),
            pmeta_reflectible_attribute(&RotationComponent::rotation)
    );
};
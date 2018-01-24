#pragma once

#include "SerializableComponent.hpp"

class LaserComponent : public kengine::SerializableComponent<LaserComponent> {
public:
    LaserComponent(const std::string & type = "") : type(type) {}

    std::string type;

public:
    pmeta_get_class_name(LaserComponent);
    pmeta_get_attributes(
        pmeta_reflectible_attribute(&LaserComponent::type)
    );
};
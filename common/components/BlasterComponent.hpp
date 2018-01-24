#pragma once

#include "SerializableComponent.hpp"

class BlasterComponent : public kengine::SerializableComponent<BlasterComponent> {
public:
    BlasterComponent(const std::string & type = "") : type(type) {}

    bool firing = false;
    std::string type;
    std::size_t shootDelay = 30;
    std::size_t currDelay = 0;

public:
    pmeta_get_class_name(BlasterComponent);
    pmeta_get_attributes(
        pmeta_reflectible_attribute(&BlasterComponent::firing),
        pmeta_reflectible_attribute(&BlasterComponent::type),
        pmeta_reflectible_attribute(&BlasterComponent::shootDelay)
    );
};
#pragma once

#include "System.hpp"

class TypeRegisterSystem : public kengine::System<TypeRegisterSystem> {
public:
    TypeRegisterSystem(kengine::EntityManager & em);
};
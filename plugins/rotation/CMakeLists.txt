#
# Thrust System
#

set(name rotation)

file(GLOB src
        *.cpp *.hpp)

add_library(${name}
        SHARED MODULE
        ${src}
        )
target_link_libraries(${name} kengine pluginManager api)
target_include_directories(${name} PRIVATE ${CMAKE_CURRENT_LIST_DIR})

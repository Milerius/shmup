cmake_minimum_required(VERSION 3.0)
project(shmup)

set(CMAKE_CXX_STANDARD 17)
if(WIN32)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /bigobj")
endif()

set(libdir "${PROJECT_SOURCE_DIR}/lib")
set(bindir "${PROJECT_SOURCE_DIR}/bin")

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${libdir})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${libdir})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${libdir})

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${bindir})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${bindir})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${bindir})

set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${bindir}/plugins)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG ${bindir}/plugins)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE ${bindir}/plugins)

#
# Actual project
#

## Kengine

set(KENGINE_SFML TRUE)
set(KENGINE_LUA TRUE)
set(KENGINE_PYTHON TRUE)
# set(KENGINE_TEST TRUE)
add_subdirectory(kengine)

## API

add_library(api INTERFACE)
target_link_libraries(api INTERFACE lua puthon)
target_include_directories(api INTERFACE common)

## Executable

set(exe_name shmup)

file(GLOB exeFiles src/*.cpp src/*.hpp
        src/components/*.cpp
        src/components/*.hpp
        src/gameobjects/*.cpp
        src/gameobjects/*.hpp
        src/systems/*.cpp
        src/systems/*.hpp)

add_executable(${exe_name} ${exeFiles} ${commonFiles})
target_include_directories(${exe_name} PRIVATE src)
target_link_libraries(${exe_name} kengine lua api)
include(cotire)
cotire(${exe_name})

add_subdirectory(plugins)

file(COPY resources scripts python sf-config.json DESTINATION ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})

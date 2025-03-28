cmake_minimum_required(VERSION 3.20)
project(shredder LANGUAGES CXX)
message(STATUS "Initiating compile using CMake ${CMAKE_VERSION}")


find_package(Qt6 6 REQUIRED COMPONENTS Core Widgets)
set(CMAKE_AUTORCC ON)
qt_standard_project_setup()

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/../cmake)

find_package(
    Botan 3.7.1
    REQUIRED
)

# Generate target 'botan_test' with specific modules
# Any Botan module can be listed here
botan_generate(
    botan_rng
auto_rng
rng
system_rng
)

add_executable(shredder
    WIN32 MACOSX_BUNDLE
    main.cpp
    widget.cpp
    widget.h
    widget.ui
    Config.cpp
    Config.h
    Global.h
    PasswordGenerator.cpp
    PasswordGenerator.h
    PasswordHealth.cpp
    PasswordHealth.h
    Random.cpp
    Random.h
    Clipboard.cpp
    Clipboard.h
    rsc.qrc
    Font.cpp
    Font.h
)

add_subdirectory(zxcvbn)
set(ZXCVBN_LIBRARIES zxcvbn)

target_link_libraries(shredder
    PRIVATE
        Qt::Core
        Qt::Widgets
        botan_rng
        ${ZXCVBN_LIBRARIES}
)

if(MSVC)
  set(shredder
      ${CMAKE_SOURCE_DIR}/src/icon.rc)
endif()


if (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
  # using Visual Studio C++
  target_link_libraries(shredder PRIVATE advapi32 user32 ws2_32)
endif()

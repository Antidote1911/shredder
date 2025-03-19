cmake_minimum_required(VERSION 3.20)
project(shredder LANGUAGES CXX)
message(STATUS "Initiating compile using CMake ${CMAKE_VERSION}")


find_package(Qt6 6 REQUIRED COMPONENTS Core Widgets)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_AUTORCC ON)
qt_standard_project_setup()

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

find_package(
    Botan 3.7.1
    REQUIRED
)

# Generate target 'botan_test' with specific modules
# Any Botan module can be listed here
botan_generate(
    botan_test
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
    Config.cpp Config.h Global.h PasswordGenerator.cpp PasswordGenerator.h PasswordHealth.cpp PasswordHealth.h Random.cpp Random.h
    Clipboard.cpp Clipboard.h
    rsc.qrc

    Font.cpp Font.h

)


add_library(zxcvbn STATIC zxcvbn/zxcvbn.cpp)
target_link_libraries(zxcvbn)

target_link_libraries(shredder
    PRIVATE
        Qt::Core
        Qt::Widgets
        botan_test
        zxcvbn
)



include(GNUInstallDirs)

install(TARGETS shredder
    BUNDLE  DESTINATION .
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

qt_generate_deploy_app_script(
    TARGET shredder
    OUTPUT_SCRIPT deploy_script
    NO_UNSUPPORTED_PLATFORM_ERROR
)
install(SCRIPT ${deploy_script})

## Flags (Release is the default)
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif()

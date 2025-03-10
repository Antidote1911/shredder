cmake_minimum_required(VERSION 3.19)
project(shredder LANGUAGES CXX)
message(STATUS "Initiating compile using CMake ${CMAKE_VERSION}")


find_package(Qt6 6.5 REQUIRED COMPONENTS Core Widgets)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_AUTORCC ON)
qt_standard_project_setup()

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
# Find Botan early since the version affects subsequent compiler options
find_package(Botan REQUIRED)
if(BOTAN_VERSION VERSION_GREATER_EQUAL "3.0.0")
    set(WITH_XC_BOTAN3 TRUE)
elseif(BOTAN_VERSION VERSION_LESS "2.11.0")
    # Check for minimum Botan version
    message(FATAL_ERROR "Botan 2.11.0 or higher is required")   
endif()
include_directories(SYSTEM ${BOTAN_INCLUDE_DIR})

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
        ${BOTAN_LIBRARIES}
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

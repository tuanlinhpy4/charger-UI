cmake_minimum_required(VERSION 3.16)
project(ev_charger_ui VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

option(EV_CHARGER_USE_SYSROOT_QT
    "Use Qt6 from the target sysroot through pkg-config and local host Qt tools"
    OFF)

set(EV_CHARGER_GENERATED_SOURCES)
file(GLOB_RECURSE EV_CHARGER_QML_FILES CONFIGURE_DEPENDS
    "${CMAKE_CURRENT_SOURCE_DIR}/qml/*.qml"
    "${CMAKE_CURRENT_SOURCE_DIR}/qml/qmldir"
    "${CMAKE_CURRENT_SOURCE_DIR}/qml/*/qmldir"
)

if(EV_CHARGER_USE_SYSROOT_QT)
    set(CMAKE_AUTOMOC OFF)
    set(CMAKE_AUTORCC OFF)

    find_package(PkgConfig REQUIRED)
    pkg_check_modules(QT6_SYSROOT REQUIRED IMPORTED_TARGET
        Qt6Quick
        Qt6QuickControls2
    )

    find_program(QT6_MOC_EXECUTABLE
        NAMES moc
        PATHS /usr/lib/qt6/libexec /usr/lib/x86_64-linux-gnu/qt6/libexec
        NO_DEFAULT_PATH)
    find_program(QT6_RCC_EXECUTABLE
        NAMES rcc
        PATHS /usr/lib/qt6/libexec /usr/lib/x86_64-linux-gnu/qt6/libexec
        NO_DEFAULT_PATH)

    if(NOT QT6_MOC_EXECUTABLE OR NOT QT6_RCC_EXECUTABLE)
        message(FATAL_ERROR "Qt6 host tools moc/rcc not found. Install qt6-base-dev-tools.")
    endif()

    set(EV_CHARGER_MOC_SOURCE "${CMAKE_CURRENT_BINARY_DIR}/moc_chargerbackend.cpp")
    add_custom_command(
        OUTPUT "${EV_CHARGER_MOC_SOURCE}"
        COMMAND "${QT6_MOC_EXECUTABLE}"
            ${QT6_SYSROOT_CFLAGS}
            -I "${CMAKE_CURRENT_SOURCE_DIR}"
            -f src/chargerbackend.h
            -o "${EV_CHARGER_MOC_SOURCE}"
            "${CMAKE_CURRENT_SOURCE_DIR}/src/chargerbackend.h"
        DEPENDS src/chargerbackend.h
        VERBATIM)

    set(EV_CHARGER_RCC_SOURCE "${CMAKE_CURRENT_BINARY_DIR}/qrc_resources.cpp")
    add_custom_command(
        OUTPUT "${EV_CHARGER_RCC_SOURCE}"
        COMMAND "${QT6_RCC_EXECUTABLE}"
            -name resources
            -o "${EV_CHARGER_RCC_SOURCE}"
            resources.qrc
        WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
        DEPENDS resources.qrc ${EV_CHARGER_QML_FILES}
        VERBATIM)

    list(APPEND EV_CHARGER_GENERATED_SOURCES
        "${EV_CHARGER_MOC_SOURCE}"
        "${EV_CHARGER_RCC_SOURCE}"
    )
    set(QT_VERSION_MAJOR 6)
else()
    # Try Qt6 first, fall back to Qt5
    find_package(Qt6 QUIET COMPONENTS Quick QuickControls2)
    if(NOT Qt6_FOUND)
        find_package(Qt5 5.15 REQUIRED COMPONENTS Quick QuickControls2)
        set(QT_VERSION_MAJOR 5)
    else()
        set(QT_VERSION_MAJOR 6)
    endif()
endif()

add_executable(ev_charger_ui
    src/main.cpp
    src/chargerbackend.cpp
    $<$<NOT:$<BOOL:${EV_CHARGER_USE_SYSROOT_QT}>>:resources.qrc>
    ${EV_CHARGER_GENERATED_SOURCES}
)

if(EV_CHARGER_USE_SYSROOT_QT)
    target_link_libraries(ev_charger_ui PRIVATE PkgConfig::QT6_SYSROOT)
    target_include_directories(ev_charger_ui PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}")
    target_link_options(ev_charger_ui PRIVATE
        "-L${CMAKE_SYSROOT}/lib"
        "-L${CMAKE_SYSROOT}/usr/lib"
        "-Wl,-rpath-link,${CMAKE_SYSROOT}/lib"
        "-Wl,-rpath-link,${CMAKE_SYSROOT}/usr/lib"
        "-Wl,--dynamic-linker=/lib/ld-linux-aarch64.so.1"
    )
    set_target_properties(ev_charger_ui PROPERTIES
        AUTOMOC OFF
        AUTORCC OFF
    )
elseif(QT_VERSION_MAJOR EQUAL 6)
    target_link_libraries(ev_charger_ui PRIVATE
        Qt6::Quick
        Qt6::QuickControls2
    )
else()
    target_link_libraries(ev_charger_ui PRIVATE
        Qt5::Quick
        Qt5::QuickControls2
    )
endif()

install(TARGETS ev_charger_ui RUNTIME DESTINATION bin)

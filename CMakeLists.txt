cmake_minimum_required(VERSION 3.16)
project(ev_charger_ui VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

option(EV_CHARGER_USE_SYSROOT_QT
    "Use Qt6 from the target sysroot through pkg-config and local host Qt tools"
    OFF)

set(EV_CHARGER_DEFAULT_ENABLE_LIBOCPP OFF)
if(CMAKE_SYSTEM_PROCESSOR MATCHES "^(aarch64|arm64|ARM64)$")
    set(EV_CHARGER_DEFAULT_ENABLE_LIBOCPP ON)
endif()
option(EV_CHARGER_ENABLE_LIBOCPP
    "Link the FRDM/i.MX93 libocpp install and use a real OCPP 1.6J client"
    ${EV_CHARGER_DEFAULT_ENABLE_LIBOCPP})
set(EV_CHARGER_LIBOCPP_ROOT
    "${CMAKE_CURRENT_SOURCE_DIR}/third_party/libocpp-frdm-install"
    CACHE PATH "Path to the libocpp install prefix for the FRDM/i.MX93 target")

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
        Qt6Qml
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
    find_package(Qt6 QUIET COMPONENTS Qml Quick QuickControls2)
    if(NOT Qt6_FOUND)
        find_package(Qt5 5.15 REQUIRED COMPONENTS Qml Quick QuickControls2)
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
        Qt6::Qml
        Qt6::Quick
        Qt6::QuickControls2
    )
else()
    target_link_libraries(ev_charger_ui PRIVATE
        Qt5::Qml
        Qt5::Quick
        Qt5::QuickControls2
    )
endif()

if(EV_CHARGER_ENABLE_LIBOCPP)
    find_package(Threads REQUIRED)
    find_package(OpenSSL REQUIRED)
    find_package(SQLite3 REQUIRED)

    set(EV_CHARGER_LIBOCPP_LIB_DIR "${EV_CHARGER_LIBOCPP_ROOT}/lib")
    set(EV_CHARGER_LIBOCPP_STATIC_LIBS
        "${EV_CHARGER_LIBOCPP_LIB_DIR}/libocpp.a"
        "${EV_CHARGER_LIBOCPP_LIB_DIR}/libeverest_log.a"
        "${EV_CHARGER_LIBOCPP_LIB_DIR}/libevse_security.a"
        "${EV_CHARGER_LIBOCPP_LIB_DIR}/libeverest_sqlite.a"
        "${EV_CHARGER_LIBOCPP_LIB_DIR}/libnlohmann_json_schema_validator.a"
        "${EV_CHARGER_LIBOCPP_LIB_DIR}/libdate-tz.a"
    )
    set(EV_CHARGER_LIBOCPP_SHARED_LINK_LIBS
        "${EV_CHARGER_LIBOCPP_LIB_DIR}/libwebsockets.so"
        "${EV_CHARGER_LIBOCPP_LIB_DIR}/libboost_log_setup.so"
        "${EV_CHARGER_LIBOCPP_LIB_DIR}/libboost_log.so"
        "${EV_CHARGER_LIBOCPP_LIB_DIR}/libboost_program_options.so"
        "${EV_CHARGER_LIBOCPP_LIB_DIR}/libboost_regex.so"
        "${EV_CHARGER_LIBOCPP_LIB_DIR}/libboost_thread.so"
        "${EV_CHARGER_LIBOCPP_LIB_DIR}/libboost_filesystem.so"
        "${EV_CHARGER_LIBOCPP_LIB_DIR}/libboost_chrono.so"
        "${EV_CHARGER_LIBOCPP_LIB_DIR}/libboost_atomic.so"
        "${EV_CHARGER_LIBOCPP_LIB_DIR}/libboost_system.so"
    )

    foreach(_lib IN LISTS EV_CHARGER_LIBOCPP_STATIC_LIBS EV_CHARGER_LIBOCPP_SHARED_LINK_LIBS)
        if(NOT EXISTS "${_lib}")
            message(FATAL_ERROR "EV_CHARGER_ENABLE_LIBOCPP is ON but required library is missing: ${_lib}")
        endif()
    endforeach()
    if(NOT EXISTS "${EV_CHARGER_LIBOCPP_ROOT}/share/everest/modules/OCPP/config.json")
        message(FATAL_ERROR "libocpp OCPP share directory not found under ${EV_CHARGER_LIBOCPP_ROOT}")
    endif()

    target_compile_definitions(ev_charger_ui PRIVATE
        EV_CHARGER_ENABLE_LIBOCPP=1
        EV_CHARGER_LIBOCPP_ROOT="${EV_CHARGER_LIBOCPP_ROOT}")
    target_include_directories(ev_charger_ui PRIVATE
        "${EV_CHARGER_LIBOCPP_ROOT}/include")
    target_link_libraries(ev_charger_ui PRIVATE
        "-Wl,--start-group"
        ${EV_CHARGER_LIBOCPP_STATIC_LIBS}
        "-Wl,--end-group"
        ${EV_CHARGER_LIBOCPP_SHARED_LINK_LIBS}
        OpenSSL::SSL
        OpenSSL::Crypto
        SQLite::SQLite3
        Threads::Threads
    )
    target_link_options(ev_charger_ui PRIVATE
        "-Wl,--disable-new-dtags"
        "-Wl,-rpath-link,${EV_CHARGER_LIBOCPP_LIB_DIR}")
    set_target_properties(ev_charger_ui PROPERTIES
        BUILD_RPATH "${EV_CHARGER_LIBOCPP_LIB_DIR}"
        INSTALL_RPATH "$ORIGIN/../lib")

    file(GLOB EV_CHARGER_LIBOCPP_RUNTIME_LIBS
        "${EV_CHARGER_LIBOCPP_LIB_DIR}/libboost_*.so.1.84.0"
        "${EV_CHARGER_LIBOCPP_LIB_DIR}/libwebsockets.so.20")
    install(FILES ${EV_CHARGER_LIBOCPP_RUNTIME_LIBS} DESTINATION lib)
    install(DIRECTORY "${EV_CHARGER_LIBOCPP_ROOT}/share/everest/modules/OCPP"
        DESTINATION share/everest/modules)
endif()

install(TARGETS ev_charger_ui RUNTIME DESTINATION bin)

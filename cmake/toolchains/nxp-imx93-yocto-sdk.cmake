# CMake toolchain for an NXP i.MX93 EVK Yocto SDK.
#
# Usage with a full Yocto SDK:
#   source /opt/fsl-imx-xwayland/<version>/environment-setup-armv8a-poky-linux
#   cmake -S . -B build-imx93 \
#     -DCMAKE_TOOLCHAIN_FILE=cmake/toolchains/nxp-imx93-yocto-sdk.cmake
#
# Usage with a local target sysroot copied into this project:
#   cmake -S . -B build-imx93 \
#     -DCMAKE_TOOLCHAIN_FILE=cmake/toolchains/nxp-imx93-yocto-sdk.cmake \
#     -DYOCTO_TARGET_SYSROOT=$PWD/sysroot
#
# The Yocto environment script exports the compiler, sysroot, pkg-config, and
# Qt host tools. This file keeps CMake searches inside that SDK sysroot.

set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR aarch64)

get_filename_component(_TOOLCHAIN_PROJECT_ROOT "${CMAKE_CURRENT_LIST_DIR}/../.." ABSOLUTE)

if(DEFINED YOCTO_TARGET_SYSROOT)
    set(_YOCTO_TARGET_SYSROOT "${YOCTO_TARGET_SYSROOT}")
elseif(DEFINED ENV{SDKTARGETSYSROOT})
    set(_YOCTO_TARGET_SYSROOT "$ENV{SDKTARGETSYSROOT}")
elseif(DEFINED ENV{OECORE_TARGET_SYSROOT})
    set(_YOCTO_TARGET_SYSROOT "$ENV{OECORE_TARGET_SYSROOT}")
elseif(EXISTS "${_TOOLCHAIN_PROJECT_ROOT}/sysroot/usr")
    set(_YOCTO_TARGET_SYSROOT "${_TOOLCHAIN_PROJECT_ROOT}/sysroot")
else()
    message(FATAL_ERROR
        "Yocto target sysroot not found. Source the SDK environment-setup-* file, "
        "set YOCTO_TARGET_SYSROOT, or put the target sysroot at ./sysroot.")
endif()

if(NOT IS_DIRECTORY "${_YOCTO_TARGET_SYSROOT}/usr")
    message(FATAL_ERROR "Invalid Yocto target sysroot: ${_YOCTO_TARGET_SYSROOT}")
endif()

if(NOT DEFINED CMAKE_C_COMPILER)
    if(DEFINED ENV{CC})
        set(CMAKE_C_COMPILER "$ENV{CC}" CACHE FILEPATH "C compiler")
    else()
        find_program(_YOCTO_C_COMPILER
            NAMES aarch64-poky-linux-gcc aarch64-linux-gnu-gcc
            PATHS
                "$ENV{OECORE_NATIVE_SYSROOT}/usr/bin"
                "$ENV{OECORE_NATIVE_SYSROOT}/usr/bin/aarch64-poky-linux"
            NO_CMAKE_FIND_ROOT_PATH
        )
        if(_YOCTO_C_COMPILER)
            set(CMAKE_C_COMPILER "${_YOCTO_C_COMPILER}" CACHE FILEPATH "C compiler")
        endif()
    endif()
endif()

if(NOT DEFINED CMAKE_CXX_COMPILER)
    if(DEFINED ENV{CXX})
        set(CMAKE_CXX_COMPILER "$ENV{CXX}" CACHE FILEPATH "C++ compiler")
    else()
        find_program(_YOCTO_CXX_COMPILER
            NAMES aarch64-poky-linux-g++ aarch64-linux-gnu-g++
            PATHS
                "$ENV{OECORE_NATIVE_SYSROOT}/usr/bin"
                "$ENV{OECORE_NATIVE_SYSROOT}/usr/bin/aarch64-poky-linux"
            NO_CMAKE_FIND_ROOT_PATH
        )
        if(_YOCTO_CXX_COMPILER)
            set(CMAKE_CXX_COMPILER "${_YOCTO_CXX_COMPILER}" CACHE FILEPATH "C++ compiler")
        endif()
    endif()
endif()

if(NOT CMAKE_CXX_COMPILER)
    message(FATAL_ERROR
        "Host-executable AArch64 cross compiler not found. Source the Yocto SDK "
        "environment-setup-* file, install a host cross compiler such as "
        "aarch64-linux-gnu-g++, or pass -DCMAKE_CXX_COMPILER=/path/to/aarch64-g++. "
        "Do not use ./sysroot/usr/bin/g++; it is an ARM64 target binary.")
endif()

set(CMAKE_SYSROOT "${_YOCTO_TARGET_SYSROOT}" CACHE PATH "Yocto target sysroot")
set(CMAKE_FIND_ROOT_PATH "${_YOCTO_TARGET_SYSROOT}" CACHE STRING "Yocto target root")
set(ENV{PKG_CONFIG_SYSROOT_DIR} "${_YOCTO_TARGET_SYSROOT}")
set(ENV{PKG_CONFIG_LIBDIR} "${_YOCTO_TARGET_SYSROOT}/usr/lib/pkgconfig:${_YOCTO_TARGET_SYSROOT}/usr/share/pkgconfig")
find_program(_HOST_PKG_CONFIG_EXECUTABLE
    NAMES pkg-config
    NO_CMAKE_FIND_ROOT_PATH)
if(_HOST_PKG_CONFIG_EXECUTABLE)
    set(PKG_CONFIG_EXECUTABLE "${_HOST_PKG_CONFIG_EXECUTABLE}" CACHE FILEPATH "Host pkg-config")
endif()

list(APPEND CMAKE_PREFIX_PATH
    "${_YOCTO_TARGET_SYSROOT}/usr"
    "${_YOCTO_TARGET_SYSROOT}/usr/lib/cmake"
)

if(DEFINED ENV{OECORE_NATIVE_SYSROOT})
    set(QT_HOST_PATH "$ENV{OECORE_NATIVE_SYSROOT}/usr" CACHE PATH "Yocto SDK host Qt prefix")
    set(QT_HOST_PATH_CMAKE_DIR "$ENV{OECORE_NATIVE_SYSROOT}/usr/lib/cmake" CACHE PATH "Yocto SDK host Qt CMake packages")
endif()

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

set(CMAKE_INSTALL_PREFIX "/usr/local" CACHE PATH "Install prefix on target")

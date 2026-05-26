# Install script for directory: /home/anhtu/Downloads/ev_charger_ui/.cache/CPM/date/3cd317cb796b48234fe000975b0b377f4ec5f6c3/date

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp-frdm-install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "TRUE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/usr/bin/aarch64-linux-gnu-objdump")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/date" TYPE FILE FILES
    "/home/anhtu/Downloads/ev_charger_ui/.cache/CPM/date/3cd317cb796b48234fe000975b0b377f4ec5f6c3/date/include/date/date.h"
    "/home/anhtu/Downloads/ev_charger_ui/.cache/CPM/date/3cd317cb796b48234fe000975b0b377f4ec5f6c3/date/include/date/solar_hijri.h"
    "/home/anhtu/Downloads/ev_charger_ui/.cache/CPM/date/3cd317cb796b48234fe000975b0b377f4ec5f6c3/date/include/date/islamic.h"
    "/home/anhtu/Downloads/ev_charger_ui/.cache/CPM/date/3cd317cb796b48234fe000975b0b377f4ec5f6c3/date/include/date/iso_week.h"
    "/home/anhtu/Downloads/ev_charger_ui/.cache/CPM/date/3cd317cb796b48234fe000975b0b377f4ec5f6c3/date/include/date/julian.h"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/anhtu/Downloads/ev_charger_ui/build-libocpp-frdm/_deps/date-build/libdate-tz.a")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/date" TYPE FILE FILES "/home/anhtu/Downloads/ev_charger_ui/.cache/CPM/date/3cd317cb796b48234fe000975b0b377f4ec5f6c3/date/include/date/tz.h")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/date/dateTargets.cmake")
    file(DIFFERENT EXPORT_FILE_CHANGED FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/date/dateTargets.cmake"
         "/home/anhtu/Downloads/ev_charger_ui/build-libocpp-frdm/_deps/date-build/CMakeFiles/Export/lib/cmake/date/dateTargets.cmake")
    if(EXPORT_FILE_CHANGED)
      file(GLOB OLD_CONFIG_FILES "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/date/dateTargets-*.cmake")
      if(OLD_CONFIG_FILES)
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/date/dateTargets.cmake\" will be replaced.  Removing files [${OLD_CONFIG_FILES}].")
        file(REMOVE ${OLD_CONFIG_FILES})
      endif()
    endif()
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/date" TYPE FILE FILES "/home/anhtu/Downloads/ev_charger_ui/build-libocpp-frdm/_deps/date-build/CMakeFiles/Export/lib/cmake/date/dateTargets.cmake")
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/date" TYPE FILE FILES "/home/anhtu/Downloads/ev_charger_ui/build-libocpp-frdm/_deps/date-build/CMakeFiles/Export/lib/cmake/date/dateTargets-release.cmake")
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/date" TYPE FILE FILES
    "/home/anhtu/Downloads/ev_charger_ui/.cache/CPM/date/3cd317cb796b48234fe000975b0b377f4ec5f6c3/date/cmake/dateConfig.cmake"
    "/home/anhtu/Downloads/ev_charger_ui/build-libocpp-frdm/_deps/date-build/dateConfigVersion.cmake"
    )
endif()


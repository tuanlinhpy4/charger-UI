# Install script for directory: /home/anhtu/Downloads/ev_charger_ui

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp-frdm-install/lib/libboost_atomic.so.1.84.0"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp-frdm-install/lib/libboost_chrono.so.1.84.0"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp-frdm-install/lib/libboost_date_time.so.1.84.0"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp-frdm-install/lib/libboost_filesystem.so.1.84.0"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp-frdm-install/lib/libboost_log.so.1.84.0"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp-frdm-install/lib/libboost_log_setup.so.1.84.0"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp-frdm-install/lib/libboost_program_options.so.1.84.0"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp-frdm-install/lib/libboost_random.so.1.84.0"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp-frdm-install/lib/libboost_regex.so.1.84.0"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp-frdm-install/lib/libboost_serialization.so.1.84.0"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp-frdm-install/lib/libboost_system.so.1.84.0"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp-frdm-install/lib/libboost_thread.so.1.84.0"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp-frdm-install/lib/libboost_wserialization.so.1.84.0"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp-frdm-install/lib/libwebsockets.so.20"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/everest/modules" TYPE DIRECTORY FILES "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp-frdm-install/share/everest/modules/OCPP")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/ev_charger_ui" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/ev_charger_ui")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/ev_charger_ui"
         RPATH "\$ORIGIN/../lib")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/home/anhtu/Downloads/ev_charger_ui/build-imx93_evk/ev_charger_ui")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/ev_charger_ui" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/ev_charger_ui")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/ev_charger_ui"
         OLD_RPATH "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp-frdm-install/lib:"
         NEW_RPATH "\$ORIGIN/../lib")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/aarch64-linux-gnu-strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/ev_charger_ui")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/home/anhtu/Downloads/ev_charger_ui/build-imx93_evk/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")

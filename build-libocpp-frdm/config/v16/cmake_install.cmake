# Install script for directory: /home/anhtu/Downloads/ev_charger_ui/third_party/libocpp/config/v16

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/everest/modules/OCPP/core_migrations" TYPE FILE FILES
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp/config/v16/core_migrations/1_up-initial.sql"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp/config/v16/core_migrations/2_down-offline-transaction.sql"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp/config/v16/core_migrations/2_up-offline-transaction.sql"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp/config/v16/core_migrations/3_down-persist-normal-messages.sql"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp/config/v16/core_migrations/3_up-persist-normal-messages.sql"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp/config/v16/core_migrations/4_down-drop-ocsp-request.sql"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp/config/v16/core_migrations/4_up-drop-ocsp-request.sql"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/everest/modules/OCPP/profile_schemas" TYPE FILE FILES
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp/config/v16/profile_schemas/Config.json"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp/config/v16/profile_schemas/Core.json"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp/config/v16/profile_schemas/FirmwareManagement.json"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp/config/v16/profile_schemas/Internal.json"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp/config/v16/profile_schemas/LocalAuthListManagement.json"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp/config/v16/profile_schemas/Reservation.json"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp/config/v16/profile_schemas/SmartCharging.json"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp/config/v16/profile_schemas/Security.json"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp/config/v16/profile_schemas/PnC.json"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp/config/v16/profile_schemas/CostAndPrice.json"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/everest/modules/OCPP" TYPE FILE FILES
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp/config/v16/config.json"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp/config/v16/config-docker.json"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp/config/v16/config-full.json"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp/config/v16/config-docker-tls.json"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp/config/v16/../logging.ini"
    )
endif()


# Install script for directory: /home/anhtu/Downloads/ev_charger_ui/third_party/libocpp/config/v2

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/everest/modules/OCPP201/core_migrations" TYPE FILE FILES
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp/config/v2/core_migrations/1_up-initial.sql"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp/config/v2/core_migrations/2_down-auth_cache_management.sql"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp/config/v2/core_migrations/2_up-auth_cache_management.sql"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp/config/v2/core_migrations/3_down-persist-normal-messages.sql"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp/config/v2/core_migrations/3_up-persist-normal-messages.sql"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp/config/v2/core_migrations/4_down-transactions_db.sql"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp/config/v2/core_migrations/4_up-transactions_db.sql"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp/config/v2/core_migrations/5_down-charging_profiles_db.sql"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp/config/v2/core_migrations/5_up-charging_profiles_db.sql"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp/config/v2/core_migrations/6_down-charging_profiles_source_tx_id.sql"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp/config/v2/core_migrations/6_up-charging_profiles_source_tx_id.sql"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/everest/modules/OCPP201/device_model_migrations" TYPE FILE FILES
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp/config/v2/device_model_migrations/1_up-initial.sql"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp/config/v2/device_model_migrations/2_down-variable_source.sql"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp/config/v2/device_model_migrations/2_up-variable_source.sql"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp/config/v2/device_model_migrations/3_down-variable_required.sql"
    "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp/config/v2/device_model_migrations/3_up-variable_required.sql"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/everest/modules/OCPP201" TYPE FILE FILES "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp/config/v2/../logging.ini")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/everest/modules/OCPP201/component_config/standardized" TYPE DIRECTORY FILES "/home/anhtu/Downloads/ev_charger_ui/third_party/libocpp/config/v2/component_config/standardized/")
endif()


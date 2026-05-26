set(ENV{EVEREST_EDM_WORKSPACE} /home/anhtu/Downloads/ev_charger_ui/third_party)
set(CPM_USE_NAMED_CACHE_DIRECTORIES ON)
if("nlohmann_json" IN_LIST EVEREST_EXCLUDE_DEPENDENCIES)
    message(STATUS "Excluding dependency nlohmann_json")
else()
CPMAddPackage(
    NAME nlohmann_json
    GIT_REPOSITORY https://github.com/nlohmann/json
    GIT_TAG v3.12.0
    OPTIONS
        "JSON_BuildTests OFF" "JSON_MultipleHeaders ON"
)
endif()

if("nlohmann_json_schema_validator" IN_LIST EVEREST_EXCLUDE_DEPENDENCIES)
    message(STATUS "Excluding dependency nlohmann_json_schema_validator")
else()
CPMAddPackage(
    NAME nlohmann_json_schema_validator
    GIT_REPOSITORY https://github.com/pboettch/json-schema-validator
    GIT_TAG 2.3.0
    OPTIONS
        "JSON_VALIDATOR_INSTALL OFF" "JSON_VALIDATOR_BUILD_TESTS OFF" "JSON_VALIDATOR_BUILD_EXAMPLES OFF" "JSON_VALIDATOR_BUILD_SHARED_LIBS ON"
)
endif()

if("liblog" IN_LIST EVEREST_EXCLUDE_DEPENDENCIES)
    message(STATUS "Excluding dependency liblog")
else()
CPMAddPackage(
    NAME liblog
    GIT_REPOSITORY https://github.com/EVerest/liblog.git
    GIT_TAG v0.3.0
    OPTIONS
        "BUILD_EXAMPLES OFF"
)
endif()

if("libtimer" IN_LIST EVEREST_EXCLUDE_DEPENDENCIES)
    message(STATUS "Excluding dependency libtimer")
else()
CPMAddPackage(
    NAME libtimer
    GIT_REPOSITORY https://github.com/EVerest/libtimer.git
    GIT_TAG v0.1.3
    OPTIONS
        "BUILD_EXAMPLES OFF"
)
endif()

if("date" IN_LIST EVEREST_EXCLUDE_DEPENDENCIES)
    message(STATUS "Excluding dependency date")
else()
CPMAddPackage(
    NAME date
    GIT_REPOSITORY https://github.com/HowardHinnant/date.git
    GIT_TAG v3.0.4
    OPTIONS
        "BUILD_TZ_LIB ON" "HAS_REMOTE_API 0" "USE_AUTOLOAD 0" "USE_SYSTEM_TZ_DB ON"
)
endif()

if("libevse-security" IN_LIST EVEREST_EXCLUDE_DEPENDENCIES)
    message(STATUS "Excluding dependency libevse-security")
else()
CPMAddPackage(
    NAME libevse-security
    GIT_REPOSITORY https://github.com/EVerest/libevse-security.git
    GIT_TAG v0.10.0
)
endif()

if("libwebsockets" IN_LIST EVEREST_EXCLUDE_DEPENDENCIES)
    message(STATUS "Excluding dependency libwebsockets")
else()
CPMAddPackage(
    NAME libwebsockets
    GIT_REPOSITORY https://github.com/warmcat/libwebsockets.git
    GIT_TAG v4.4.1
    OPTIONS
        "CMAKE_POLICY_VERSION_MINIMUM 3.5" "CMAKE_POLICY_DEFAULT_CMP0077 NEW" "LWS_ROLE_RAW_FILE OFF" "LWS_UNIX_SOCK OFF" "LWS_IPV6 ON" "LWS_WITH_SYS_STATE OFF" "LWS_WITH_SYS_SMD OFF" "LWS_WITH_UPNG OFF" "LWS_WITH_JPEG OFF" "LWS_WITH_DLO OFF" "LWS_WITH_SECURE_STREAMS OFF" "LWS_WITH_STATIC OFF" "LWS_WITH_LHP OFF" "LWS_WITH_LEJP_CONF OFF" "LWS_WITH_MINIMAL_EXAMPLES OFF" "LWS_WITH_CACHE_NSCOOKIEJAR OFF" "LWS_WITHOUT_TESTAPPS ON" "LWS_WITHOUT_TEST_SERVER ON" "LWS_WITHOUT_TEST_SERVER_EXTPOLL ON" "LWS_WITHOUT_TEST_PING ON" "LWS_WITHOUT_TEST_CLIENT ON" "LWS_INSTALL_LIB_DIR ${CMAKE_INSTALL_LIBDIR}"
)
endif()

if("gtest" IN_LIST EVEREST_EXCLUDE_DEPENDENCIES)
    message(STATUS "Excluding dependency gtest")
elseif(LIBOCPP_BUILD_TESTING)
CPMAddPackage(
    NAME gtest
    GIT_REPOSITORY https://github.com/google/googletest.git
    GIT_TAG release-1.12.1
)
else()
    message(STATUS "Excluding dependency gtest based on cmake_condition")
endif()

if("everest-sqlite" IN_LIST EVEREST_EXCLUDE_DEPENDENCIES)
    message(STATUS "Excluding dependency everest-sqlite")
else()
CPMAddPackage(
    NAME everest-sqlite
    GIT_REPOSITORY https://github.com/EVerest/everest-sqlite.git
    GIT_TAG v0.1.4
)
endif()


execute_process(
    COMMAND "${EVEREST_DEPENDENCY_MANAGER}" release --everest-core-dir ${PROJECT_SOURCE_DIR} --build-dir ${CMAKE_BINARY_DIR} --out ${CMAKE_BINARY_DIR}/release.json
)

install(
    FILES "${CMAKE_BINARY_DIR}/release.json"
    DESTINATION "${CMAKE_INSTALL_SYSCONFDIR}/everest"
)
set(ENV{EVEREST_EDM_WORKSPACE} /home/anhtu/Downloads/ev_charger_ui/third_party)
set(CPM_USE_NAMED_CACHE_DIRECTORIES ON)
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

if("gtest" IN_LIST EVEREST_EXCLUDE_DEPENDENCIES)
    message(STATUS "Excluding dependency gtest")
elseif(LIBTIMER_BUILD_TESTING)
CPMAddPackage(
    NAME gtest
    GIT_REPOSITORY https://github.com/google/googletest.git
    GIT_TAG release-1.12.1
)
else()
    message(STATUS "Excluding dependency gtest based on cmake_condition")
endif()


execute_process(
    COMMAND "${EVEREST_DEPENDENCY_MANAGER}" release --everest-core-dir ${PROJECT_SOURCE_DIR} --build-dir ${CMAKE_BINARY_DIR} --out ${CMAKE_BINARY_DIR}/release.json
)

install(
    FILES "${CMAKE_BINARY_DIR}/release.json"
    DESTINATION "${CMAKE_INSTALL_SYSCONFDIR}/everest"
)
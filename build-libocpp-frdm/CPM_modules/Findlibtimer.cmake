include("/home/anhtu/Downloads/ev_charger_ui/third_party/everest-cmake/3rd_party/CPM.cmake")
CPMAddPackage("NAME;libtimer;GIT_REPOSITORY;https://github.com/EVerest/libtimer.git;GIT_TAG;v0.1.3;OPTIONS;BUILD_EXAMPLES OFF")
set(libtimer_FOUND TRUE)
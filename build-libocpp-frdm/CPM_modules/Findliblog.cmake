include("/home/anhtu/Downloads/ev_charger_ui/third_party/everest-cmake/3rd_party/CPM.cmake")
CPMAddPackage("NAME;liblog;GIT_REPOSITORY;https://github.com/EVerest/liblog.git;GIT_TAG;v0.3.0;OPTIONS;BUILD_EXAMPLES OFF")
set(liblog_FOUND TRUE)
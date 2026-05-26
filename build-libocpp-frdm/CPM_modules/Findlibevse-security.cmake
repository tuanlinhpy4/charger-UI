include("/home/anhtu/Downloads/ev_charger_ui/third_party/everest-cmake/3rd_party/CPM.cmake")
CPMAddPackage("NAME;libevse-security;GIT_REPOSITORY;https://github.com/EVerest/libevse-security.git;GIT_TAG;v0.10.0")
set(libevse-security_FOUND TRUE)
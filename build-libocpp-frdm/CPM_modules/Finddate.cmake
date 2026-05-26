include("/home/anhtu/Downloads/ev_charger_ui/third_party/everest-cmake/3rd_party/CPM.cmake")
CPMAddPackage("NAME;date;GIT_REPOSITORY;https://github.com/HowardHinnant/date.git;GIT_TAG;v3.0.4;OPTIONS;BUILD_TZ_LIB ON;HAS_REMOTE_API 0;USE_AUTOLOAD 0;USE_SYSTEM_TZ_DB ON")
set(date_FOUND TRUE)
include("/home/anhtu/Downloads/ev_charger_ui/third_party/everest-cmake/3rd_party/CPM.cmake")
CPMAddPackage("NAME;nlohmann_json;GIT_REPOSITORY;https://github.com/nlohmann/json;GIT_TAG;v3.12.0;OPTIONS;JSON_BuildTests OFF;JSON_MultipleHeaders ON")
set(nlohmann_json_FOUND TRUE)
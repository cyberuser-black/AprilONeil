cmake_minimum_required(VERSION 3.20)
project(AprilONeil)

find_package(Lua REQUIRED)
set(INCLUDE_DIRS ${LUA_INCLUDE_DIR})
include_directories(${INCLUDE_DIRS})

set(CMAKE_CXX_STANDARD 11)
#include "../../../AprilONeil/src/actions/Action.h"

add_executable(AprilONeil src/main.cpp
        src/actions/action.h
        src/actions/action.cpp
        src/wrappers/rules/rule_wrapper.cpp
        src/wrappers/rules/rule_wrapper.h
        src/engine.cpp
        src/engine.h
                src/types.h
        src/wrappers/data_sources/parsers/parser_wrapper.cpp
        src/wrappers/data_sources/parsers/parser_wrapper.h
                include/json11/json11.cpp
                include/json11/json11.hpp
        src/wrappers/lua_wrapper.cpp
        src/wrappers/lua_wrapper.h
                root_api/rootapi.h
        src/wrappers/data_sources/data_source_interface.h
        src/data_access.cpp
        src/data_access.h
        src/data_entry.cpp
        src/data_entry.h src/utils.cpp src/tracing/trace_entry.cpp src/tracing/trace_entry.h src/tracing/trace_log.h src/tracing/demo.cpp src/tracing/colormod.h)
target_link_libraries(AprilONeil ${LUA_LIBRARY} ${CMAKE_DL_LIBS})
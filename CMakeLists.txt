cmake_minimum_required(VERSION 3.20)
project(AprilONeil)

find_package(Lua REQUIRED)
set(INCLUDE_DIRS ${LUA_INCLUDE_DIR})
include_directories(${INCLUDE_DIRS})

set(CMAKE_CXX_STANDARD 11)

add_executable(AprilONeil src/main.cpp src/Engine.cpp src/Engine.h src/types.h src/wrappers/rules/Rule.h src/wrappers/rules/Rule.cpp src/wrappers/data_sources/parsers/ParserWrapper.cpp src/wrappers/data_sources/parsers/ParserWrapper.h include/json11/json11.cpp include/json11/json11.hpp src/wrappers/conditions/ConditionWrapper.cpp src/wrappers/conditions/ConditionWrapper.h src/wrappers/LuaWrapper.cpp src/wrappers/LuaWrapper.h src/wrappers/actions/ActionWrapper.cpp src/wrappers/actions/ActionWrapper.h root_api/rootapi.h src/wrappers/data_sources/DataSourceInterface.h src/DataAccess.cpp src/DataAccess.h src/DataEntry.cpp src/DataEntry.h)
target_link_libraries(AprilONeil ${LUA_LIBRARY} ${CMAKE_DL_LIBS})
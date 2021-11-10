cmake_minimum_required(VERSION 3.20)
project(AprilONeil)

find_package(Lua REQUIRED)
set(INCLUDE_DIRS ${LUA_INCLUDE_DIR})
include_directories(${INCLUDE_DIRS})

set(CMAKE_CXX_STANDARD 11)

add_executable(AprilONeil src/main.cpp src/Engine.cpp src/Engine.h src/types.h src/rules/Rule.h src/conditions/ICondition.h src/conditions/IsNoChange.cpp src/conditions/IsNoChange.h src/rules/Rule.cpp src/parsers/ParserWrapper.cpp src/parsers/ParserWrapper.h src/actions/IAction.h src/actions/LogCurrentParse.cpp src/actions/LogCurrentParse.h include/json11/json11.cpp include/json11/json11.hpp src/conditions/ConditionWrapper.cpp src/conditions/ConditionWrapper.h src/LuaWrapper.cpp src/LuaWrapper.h src/actions/ActionWrapper.cpp src/actions/ActionWrapper.h)
target_link_libraries(AprilONeil ${LUA_LIBRARY} ${CMAKE_DL_LIBS})
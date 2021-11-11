cmake_minimum_required(VERSION 3.20)
project(RootAgentC__)

set(CMAKE_CXX_STANDARD 14)

add_executable(RootAgentC__ main.cpp root_api.h root_api.cpp client.c server.c)

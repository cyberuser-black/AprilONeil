//
// Created by cyber on 11/3/21.
//

#include <iostream>
#include <lua.hpp>

#include "ParserWrapper.h"

#include "../../../include/Selene/include/selene.h"
#include "../LuaWrapper.h"

namespace apriloneil {
    const ParserWrapper::ParseHistory &ParserWrapper::invoke() {
        std::cout << "[C++] [ParserWrapper] Invoking '" << path << "'..." << std::endl;
        ParsedData parsed_data;

        // TODO: Actually do the parse logic, using Lua
        invoke_lua_wrapper(&parsed_data);

        history.first = history.second;
        history.second = parsed_data;
        return history;
    }

    void ParserWrapper::invoke_lua_parser(ParsedData *out_parsed_data) {
        lua_State *L;
        L = luaL_newstate();

        L = luaL_newstate(); // open Lua
        luaL_openlibs(L); // load Lua libraries
        //int n = atoi(argv[1]);
        int n = 10;

        luaL_loadfile(L, "../lua/example_parser.lua");
        lua_pcall(L, 0, 0, 0); // Execute script once to create and assign functions

        lua_getglobal(L, "parse"); // function to be called
        lua_pushnumber(L, n); // push argument

        // Call lua function with 1 argument, expect 1 return value
        if (0 == lua_pcall(L, 1, 1, 0)) {
            // Parse return value as string
            *out_parsed_data = lua_tostring(L, -1);
            lua_pop(L, 1); // pop returned value
        }
        lua_close(L);
    }

    void ParserWrapper::invoke_lua_selene(ParsedData* out_parsed_data) {
        sel::State lua{true};
        lua.Load("../lua/parsers/example_parser.lua");
        std::string lua_raw_data = lua["parse"]();
        std::string parse_error;
        json11::Json lua_parsed_data = json11::Json::parse(lua_raw_data, parse_error);
        *out_parsed_data = lua_parsed_data;
    }

    void ParserWrapper::invoke_lua_wrapper(ParsedData *out_parsed_data) {
        *out_parsed_data = LuaWrapper::parse(path);
    }

    std::string ParserWrapper::name() const {
        return path;
    }
}

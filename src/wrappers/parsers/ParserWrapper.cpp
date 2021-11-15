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

        std::cout << "[C++] [ParserWrapper] Parsed Data = " << parsed_data.dump() << "" << std::endl;
        history.first = history.second;
        history.second = parsed_data;
        return history;
    }

    void ParserWrapper::invoke_lua_wrapper(ParsedData *out_parsed_data) {
        *out_parsed_data = LuaWrapper::parse(path);
    }

    std::string ParserWrapper::name() const {
        return path;
    }
}

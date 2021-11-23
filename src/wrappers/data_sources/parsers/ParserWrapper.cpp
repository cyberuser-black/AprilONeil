//
// Created by cyber on 11/3/21.
//

#include <iostream>
#include <lua.hpp>

#include "ParserWrapper.h"

#include "../../../../include/Selene/include/selene.h"
#include "../../LuaWrapper.h"

namespace apriloneil {
    void ParserWrapper::get_data(Data* out_data) const {
        std::cout << "[C++] [ParserWrapper] Invoking '" << _lua_parser_path << "'..." << std::endl;
        invoke_lua_wrapper(out_data);
        std::cout << "[C++] [ParserWrapper] Parsed Data = " << out_data->dump() << "" << std::endl;
    }

    void ParserWrapper::invoke_lua_wrapper(Data *out_parsed_data) const {
        *out_parsed_data = LuaWrapper::parse(_lua_parser_path);
    }

    std::string ParserWrapper::name() const {
        return _lua_parser_path;
    }

    const DataSourceID &ParserWrapper::get_id() const {
        return _id;
    }
}

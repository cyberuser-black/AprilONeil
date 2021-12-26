//
// Created by cyber on 11/3/21.
//

#include <iostream>
#include <lua.hpp>

#include "parser_wrapper.h"

#include "../../lua_wrapper.h"
#include "../../../tracing/trace_entry.h"

namespace apriloneil {
    void ParserWrapper::get_data(Data* out_data) const {
        TRACE_ENTER();
        TRACE_MESSAGE("Invoking '" + _lua_parser_path + "'...");
        invoke_lua_wrapper(out_data);
        TRACE_MESSAGE("Parsed Data = " + out_data->dump());
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

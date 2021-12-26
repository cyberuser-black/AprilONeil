//
// Created by cyber on 11/8/21.
//

#include "lua_wrapper.h"
#include "../../root_api/rootapi.h"
#include "../data_access.h"
#include "../../../AprilONeil/src/actions/action.h"



void apriloneil::LuaWrapper::invoke_rule(const apriloneil::PathToLuaRule &rule) {
    sel::State lua(true);
    lua.Load(rule);
    lua["get_data_current"] = &DataAccess::get_data_current; //TODO: change to new cache get_data method/function
    lua["action"] = &Action::invoke_action;
    lua["API_trace"] = &API_trace;
    lua["invoke_rule"]();
}

apriloneil::Data apriloneil::LuaWrapper::parse(const apriloneil::PathToLuaParser &parser) {
    sel::State lua(true);

    // TODO: Load the root_api correctly
    lua["rootapi_readfile"] = &RootAPI::readfile;
    lua["API_trace"] = &API_trace;

    lua.Load(parser);
    JSONStr jsonstr = lua["parse"]();
    std::string parse_error;
    Data data = json11::Json::parse(jsonstr, parse_error);
    return data;
}

void apriloneil::API_trace(const std::string &message) {
    TRACE(message);
}

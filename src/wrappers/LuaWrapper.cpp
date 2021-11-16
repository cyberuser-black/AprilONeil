//
// Created by cyber on 11/8/21.
//

#include "LuaWrapper.h"
#include "../../root_api/rootapi.h"

bool apriloneil::LuaWrapper::evaluate(const apriloneil::PathToLuaCondition &condition,
                                      const std::string &jsonstr_a,
                                      const std::string &jsonstr_b) {
    sel::State lua(true);
    lua.Load(condition);
    int retval = lua["evaluate"](jsonstr_a, jsonstr_b);
    return (1 == retval);
}

apriloneil::ParsedData apriloneil::LuaWrapper::parse(const apriloneil::PathToLuaParser &parser) {
    sel::State lua(true);

    // TODO: Load the root_api correctly
    lua["rootapi_readfile"] = &RootAPI::readfile;

    lua.Load(parser);
    std::string jsonstr = lua["parse"]();
    std::string parse_error;
    json11::Json parsed_json = json11::Json::parse(jsonstr, parse_error);
    return parsed_json;
}

void apriloneil::LuaWrapper::do_action(const apriloneil::PathToLuaAction &action,
                                       const std::string &jsonstr) {
    sel::State lua(true);
    lua.Load(action);
    lua["do_action"](jsonstr);
}

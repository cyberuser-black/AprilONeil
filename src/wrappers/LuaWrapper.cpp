//
// Created by cyber on 11/8/21.
//

#include "LuaWrapper.h"
#include "../../root_api/rootapi.h"

bool apriloneil::LuaWrapper::evaluate(const apriloneil::PathToLuaCondition &condition,
                                      apriloneil::ParserWrapper::ParseHistory parsed_history) {
    sel::State lua(true);
    lua.Load(condition);
    std::string a = parsed_history.first.dump();
    std::string b = parsed_history.second.dump();
    int retval = lua["evaluate"](a, b);
    return retval == 1;
}

apriloneil::ParsedData apriloneil::LuaWrapper::parse(const apriloneil::PathToLuaParser &parser) {
    sel::State lua(true);

    // TODO: Load the root_api correctly
    lua["rootapi_readfile"] = &RootAPI::readfile;

    lua.Load(parser);
    std::string raw_json = lua["parse"]("dummyfile.txt");
    std::string parse_error;
    json11::Json parsed_json = json11::Json::parse(raw_json, parse_error);
    return parsed_json;
}

void apriloneil::LuaWrapper::do_action(const apriloneil::PathToLuaAction &action,
                                       apriloneil::ParserWrapper::ParseHistory parse_history) {
    sel::State lua(true);
    lua.Load(action);
    lua["do_action"](parse_history.first.dump(), parse_history.second.dump());
}

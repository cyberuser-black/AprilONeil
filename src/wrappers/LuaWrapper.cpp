//
// Created by cyber on 11/8/21.
//

#include "LuaWrapper.h"
#include "../../root_api/rootapi.h"
#include "../DataAccess.h"

bool apriloneil::LuaWrapper::evaluate(const apriloneil::PathToLuaCondition &condition) {
    sel::State lua(true);

    lua["get_data_current"] = &DataAccess::get_data_current;

    lua.Load(condition);
    int retval = lua["evaluate"]();
    return (1 == retval);
}

apriloneil::Data apriloneil::LuaWrapper::parse(const apriloneil::PathToLuaParser &parser) {
    sel::State lua(true);

    // TODO: Load the root_api correctly
    lua["rootapi_readfile"] = &RootAPI::readfile;

    lua.Load(parser);
    std::string jsonstr = lua["parse"]();
    std::string parse_error;
    Data data = json11::Json::parse(jsonstr, parse_error);
    return data;
}

void apriloneil::LuaWrapper::do_action(const apriloneil::PathToLuaAction &action) {
    sel::State lua(true);
    lua.Load(action);
    lua["do_action"]();
}

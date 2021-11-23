//
// Created by cyber on 11/8/21.
//

#include "../LuaWrapper.h"
#include "ConditionWrapper.h"

bool apriloneil::ConditionWrapper::evaluate() const {

    int retval = LuaWrapper::evaluate(_lua_condition_path);
    return retval;
}

std::string apriloneil::ConditionWrapper::name() const {
    return _lua_condition_path;
}
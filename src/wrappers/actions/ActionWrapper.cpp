//
// Created by cyber on 11/8/21.
//

#include "ActionWrapper.h"
#include "../LuaWrapper.h"

void apriloneil::ActionWrapper::do_action() const {
    LuaWrapper::do_action(_lua_action_path);
}

std::string apriloneil::ActionWrapper::name() const {
    return _lua_action_path;
}

//
// Created by cyber on 11/8/21.
//

#include "ActionWrapper.h"
#include "../LuaWrapper.h"

void apriloneil::ActionWrapper::do_action(const apriloneil::ParserWrapper::ParseHistory &parsed_history) const {
    LuaWrapper::do_action(path, parsed_history.first.dump());
}

std::string apriloneil::ActionWrapper::name() const {
    return path;
}

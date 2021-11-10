//
// Created by cyber on 11/8/21.
//

#include "../LuaWrapper.h"
#include "ConditionWrapper.h"

bool apriloneil::ConditionWrapper::evaluate(const apriloneil::ParserWrapper::ParseHistory &parsed_history) const {
    int retval = LuaWrapper::evaluate(path, parsed_history);
    return retval;
}

std::string apriloneil::ConditionWrapper::name() const {
    return path;
}
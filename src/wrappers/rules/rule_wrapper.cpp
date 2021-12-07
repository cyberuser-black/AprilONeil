//
// Created by cyber on 11/3/21.
//

#include <iostream>
#include "rule_wrapper.h"
#include "../../tracing/trace_entry.h"

namespace apriloneil {
    void RuleWrapper::invoke_rule() const {
        TRACE_ENTER();
        TRACE_MESSAGE("Invoking Rule '" + id + "'...");

        invoke_lua_wrapper();
    }


    void RuleWrapper::invoke_lua_wrapper() const {
        LuaWrapper::invoke_rule(path);
    }

    std::string RuleWrapper::name() const {
        return id;
    }
}


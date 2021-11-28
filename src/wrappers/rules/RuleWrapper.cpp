//
// Created by cyber on 11/3/21.
//

#include <iostream>
#include "RuleWrapper.h"

namespace apriloneil {
    void RuleWrapper::invoke_rule() const {
            std::cout << "[C++] [RuleWrapper] Invoking Rule '" << id << "'..." << std::endl;

            invoke_lua_wrapper();
        }


    void RuleWrapper::invoke_lua_wrapper() const{
            LuaWrapper::invoke_rule(path);
        }

    std::string RuleWrapper::name() const {
        return id;
    }
}


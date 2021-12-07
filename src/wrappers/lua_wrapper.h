//
// Created by cyber on 11/8/21.
//

#ifndef APRILONEIL_LUA_WRAPPER_H
#define APRILONEIL_LUA_WRAPPER_H

#include "../../include/Selene/include/selene/State.h"
#include "../types.h"
#include "data_sources/parsers/parser_wrapper.h"

namespace apriloneil {
    class LuaWrapper {
    public:
        static Data parse(const PathToLuaParser &);

        static void invoke_rule(const apriloneil::PathToLuaRule &rule);

        };
}
#endif //APRILONEIL_LUA_WRAPPER_H
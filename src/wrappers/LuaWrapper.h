//
// Created by cyber on 11/8/21.
//

#ifndef APRILONEIL_LUAWRAPPER_H
#define APRILONEIL_LUAWRAPPER_H

#include "../../include/Selene/include/selene/State.h"
#include "../types.h"
#include "data_sources/parsers/ParserWrapper.h"

namespace apriloneil {
    class LuaWrapper {
    public:
        static Data parse(const PathToLuaParser &);

        static void invoke_rule(const apriloneil::PathToLuaRule &rule);

        };
}
#endif //APRILONEIL_LUAWRAPPER_H
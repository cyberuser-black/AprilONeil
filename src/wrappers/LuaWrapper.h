//
// Created by cyber on 11/8/21.
//

#ifndef APRILONEIL_LUAWRAPPER_H
#define APRILONEIL_LUAWRAPPER_H

#include "../../include/Selene/include/selene/State.h"
#include "../types.h"
#include "parsers/ParserWrapper.h"

namespace apriloneil {
    class LuaWrapper {
    public:
        static ParsedData parse(const PathToLuaParser &);

        static bool evaluate(const PathToLuaCondition &, ParserWrapper::ParseHistory);

        static void do_action(const PathToLuaAction &, ParserWrapper::ParseHistory);

    };
}
#endif //APRILONEIL_LUAWRAPPER_H
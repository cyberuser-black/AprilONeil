//
// Created by cyber on 11/8/21.
//

#ifndef APRILONEIL_LUAWRAPPER_H
#define APRILONEIL_LUAWRAPPER_H

#include "conditions/ICondition.h"
#include "actions/IAction.h"
#include "../include/Selene/include/selene/State.h"

namespace apriloneil {
    class LuaWrapper {
    public:
        static ParsedData parse(const PathToLuaParser &);

        static bool evaluate(const PathToLuaCondition &, ParserWrapper::ParseHistory);

        static void do_action(const PathToLuaAction &, ParserWrapper::ParseHistory);

    };
}
#endif //APRILONEIL_LUAWRAPPER_H
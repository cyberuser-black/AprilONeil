//
// Created by cyber on 11/3/21.
//

#ifndef APRILONEIL_TYPES_H
#define APRILONEIL_TYPES_H

#include <string>
#include "../include/json11/json11.hpp"

namespace apriloneil{
    typedef json11::Json ParsedData;
    typedef std::string ParserId;  // Unique id to identify the parser in hashsets

    typedef std::string PathToLuaCode;  // A path relative to the {PROJECT_DIR}/lua/{Class}/ directory
    typedef PathToLuaCode PathToLuaParser;  // Path to a 'parser.lua' code with a 'parse()' function that returns a json str
    typedef PathToLuaCode PathToLuaCondition;  // Path to a 'condition.lua' code with an 'evaluate(a,b)' function that returns 1 (True), 0 (False)
    typedef PathToLuaCode PathToLuaAction;  // Path to an 'action.lua' code with a 'do_action(a,b)' function (void)

    typedef std::string RuleName;
    typedef std::string ConfigurationName;
}
#endif //APRILONEIL_TYPES_H

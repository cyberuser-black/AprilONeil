//
// Created by cyber on 11/3/21.
//

#ifndef APRILONEIL_TYPES_H
#define APRILONEIL_TYPES_H

#include <string>
#include <unordered_set>
#include "../include/json11/json11.hpp"

namespace apriloneil{
    typedef json11::Json Data; // The generic datatype extracted from all data sources
    typedef std::string JSONStr; // A String encoding a JSON. Example: '{"foo" : "bar"}'
    typedef std::string DataSourceID;  // Unique _id to identify the data sources in hashsets
    typedef std::pair<Data*, Data*> DataHistory;

    typedef std::string Path;  // A string representing a path relative to the {PROJECT_DIR}/lua/{Class}/ directory
    typedef Path PathToLuaCode;  // Path to some_file.lua code file
    typedef PathToLuaCode PathToLuaParser;  // Path to a 'parser.lua' code with a 'parse()' function that returns a json str
    typedef PathToLuaCode PathToLuaCondition;  // Path to a '_condition.lua' code with an 'evaluate(a,b)' function that returns 1 (True), 0 (False)
    typedef PathToLuaCode PathToLuaAction;  // Path to an '_action.lua' code with a 'do_action(a,b)' function (void)
    typedef PathToLuaCode PathToLuaRule;

    typedef std::string RuleName;
    typedef std::string ConfigurationName;
}
#endif //APRILONEIL_TYPES_H

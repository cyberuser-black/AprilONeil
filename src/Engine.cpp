//
// Created by cyber on 11/3/21.
//

#include <iostream>
#include <unistd.h>
#include "Engine.h"
#include "wrappers/data_sources/parsers/ParserWrapper.h"
#include "wrappers/conditions/ConditionWrapper.h"
#include "wrappers/actions/ActionWrapper.h"
#include "DataAccess.h"

namespace apriloneil {
    Engine::Engine(const ConfigurationName &configuration_name) {
        // TODO: Actually PARSE the data_sources, conditions and actions, for the _rules from configuration
        PathToLuaCondition lua_condition = "../lua/conditions/memfree_toolow.lua";//"../lua/conditions/example_condition.lua";
        PathToLuaAction lua_action = "../lua/actions/example_action.lua";
        auto *condition = new ConditionWrapper(lua_condition);
        auto *action = new ActionWrapper(lua_action);
        auto *rule = new Rule(condition, action);
        std::cout << "[C++] [Engine] Adding rule '" << condition->name() << "' --> '" << action->name() << "'..."
                  << std::endl;
        _rules.push_back(rule);
    }

    [[noreturn]] void Engine::run_forever(double delay) {
        std::cout << "[C++] [Engine] Running..." << std::endl;
        auto data_access = DataAccess::GetInstance();
        while (true) {
            std::cout << "[C++] [Engine] Running _rules..." << std::endl;
            for (const auto rule: _rules) {
                rule->run(data_access);
            }
            std::cout << "[C++] [Engine] ------------------ delay between snapshots ---------------- " << std::endl;
            sleep(delay);
        }
    }
}
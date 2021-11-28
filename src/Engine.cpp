//
// Created by cyber on 11/3/21.
//

#include <iostream>
#include <unistd.h>
#include "Engine.h"
#include "wrappers/data_sources/parsers/ParserWrapper.h"
#include "DataAccess.h"
#include "wrappers/rules/RuleWrapper.h"

namespace apriloneil {
    Engine::Engine(const ConfigurationName &configuration_name) {
        // TODO: Actually PARSE the data_sources, conditions and actions, for the _rules from configuration
        PathToLuaRule lua_rule = "../lua/rules/memfree_too_low.lua";//"../lua/rules/example_rule.lua";
        auto *rule = new RuleWrapper(lua_rule);
        std::cout << "[C++] [Engine] Adding rule '" << rule->name()  << "'..." << std::endl;
        _rules.push_back(rule);
    }

    [[noreturn]] void Engine::run_forever(double delay) {
        std::cout << "[C++] [Engine] Running..." << std::endl;
        auto data_access = DataAccess::GetInstance();
        while (true) {
            std::cout << "[C++] [Engine] Running _rules..." << std::endl;
            for (const auto rule: _rules) {
                rule->invoke_rule();
            }
            std::cout << "[C++] [Engine] ------------------ delay between snapshots ---------------- " << std::endl;
            sleep(delay);
        }
    }
}
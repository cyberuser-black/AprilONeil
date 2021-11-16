//
// Created by cyber on 11/3/21.
//

#include <iostream>
#include <unistd.h>
#include "Engine.h"
#include "wrappers/parsers/ParserWrapper.h"
#include "wrappers/conditions/ConditionWrapper.h"
#include "wrappers/actions/ActionWrapper.h"

namespace apriloneil {
    Engine::Engine(const ConfigurationName &configuration_name) {
        // TODO: Actually PARSE the parsers, conditions and actions, for the rules from configuration
        PathToLuaParser lua_parser = "../lua/parsers/meminfo.lua";//"../lua/parsers/example_parser.lua";
        PathToLuaCondition lua_condition = "../lua/conditions/memfree_toolow.lua";//"../lua/conditions/example_condition.lua";
        PathToLuaAction lua_action = "../lua/actions/example_action.lua";
        auto *parser_wrapper = new ParserWrapper(lua_parser);
        auto *condition = new ConditionWrapper(lua_condition);
        auto *action = new ActionWrapper(lua_action);
        auto *rule = new Rule(parser_wrapper, condition, action);
        std::cout << "[C++] [Engine] Adding parser '" << parser_wrapper->name() << "'..." << std::endl;
        parser_wrappers.push_back(parser_wrapper);
        std::cout << "[C++] [Engine] Adding rule '" << condition->name() << "' --> '" << action->name() << "'..."
                  << std::endl;
        rules.push_back(rule);
        snapshots[parser_wrapper->id] = ParserWrapper::ParseHistory("", "");

    }

    [[noreturn]] void Engine::run_forever(double delay) {
        std::cout << "[C++] [Engine] Running..." << std::endl;
        while (true) {
            std::cout << "[C++] [Engine] Taking snapshots from parsers..." << std::endl;
            for (auto parser_wrapper: parser_wrappers) {
                auto parse_history = parser_wrapper->invoke();
                snapshots[parser_wrapper->id] = parse_history;
            }
            std::cout << "[C++] [Engine] Running rules..." << std::endl;
            for (const auto rule: rules) {
                const auto parse_history = snapshots[rule->parser_id];
                rule->run(parse_history);
            }
            std::cout << "[C++] [Engine] ------------------ delay between snapshots ---------------- " << std::endl;
            sleep(delay);
        }
    }
}
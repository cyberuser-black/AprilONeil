//
// Created by cyber on 11/3/21.
//

#include <iostream>
#include <unistd.h>
#include "engine.h"
#include "wrappers/data_sources/parsers/parser_wrapper.h"
#include "data_access.h"
#include "wrappers/rules/rule_wrapper.h"
#include "utils.h"

namespace apriloneil {
    Engine::Engine(const ConfigurationName &configuration_name) {
        // TODO: Actually PARSE the data_sources, conditions and actions, for the _rules from configuration

        std::vector<PathToLuaRule> rule_paths;
        if (0 != list_dir_ending_with("../lua/rules", ".lua", &rule_paths)){
            std::cout << "[C++] [Engine] Failed to read rules!" << std::endl;
            return;
        }

        for (auto path : rule_paths){
            auto *rule = new RuleWrapper(path);
            std::cout << "[C++] [Engine] Adding " << path << " to rules..." << std::endl;
            _rules.push_back(rule);
        }
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
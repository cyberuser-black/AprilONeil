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
#include "tracing/trace_entry.h"

namespace apriloneil {
    Engine::Engine(const ConfigurationName &configuration_name) {
        // TODO: Actually PARSE the data_sources, conditions and actions, for the _rules from configuration
        TRACE_ENTER();
        std::vector<PathToLuaRule> rule_paths;
        if (0 != list_dir_ending_with("../lua/rules", ".lua", &rule_paths)){
            TRACE_MESSAGE("[C++] [Engine] Failed to read rules!");
            return;
        }

        for (auto path : rule_paths){
            auto *rule = new RuleWrapper(path);
            TRACE_MESSAGE("[C++] [Engine] Adding " + path + " to rules...");
            _rules.push_back(rule);
        }
    }

    [[noreturn]] void Engine::run_forever(double delay) {
        TRACE_ENTER();
        auto data_access = DataAccess::GetInstance();
        while (true) {
            TRACE_MESSAGE("Running _rules...");
            for (const auto rule: _rules) {
                rule->invoke_rule();
            }
            TRACE_MESSAGE(" ------------------ delay between snapshots ---------------- " );
            sleep(delay);
        }
    }
}
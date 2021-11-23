//
// Created by cyber on 11/3/21.
//

#ifndef APRILONEIL_ENGINE_H
#define APRILONEIL_ENGINE_H

#include <unordered_map>
#include <vector>
#include "wrappers/data_sources/parsers/ParserWrapper.h"
#include "wrappers/rules/Rule.h"

namespace apriloneil {
    class Engine {
        typedef std::vector<Rule*> Rules;
    public:
        Engine(const ConfigurationName& configuration_name);

        [[noreturn]] void run_forever(double delay=3);

    private:
        Rules _rules;
    };
}


#endif //APRILONEIL_ENGINE_H

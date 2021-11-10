//
// Created by cyber on 11/3/21.
//

#ifndef APRILONEIL_ENGINE_H
#define APRILONEIL_ENGINE_H

#include <unordered_map>
#include <vector>
#include "wrappers/parsers/ParserWrapper.h"
#include "wrappers/rules/Rule.h"

namespace apriloneil {
    class Engine {
        typedef std::vector<ParserWrapper*> ParserWrappers;
        typedef std::vector<Rule*> Rules;
        typedef std::unordered_map<ParserId, ParserWrapper::ParseHistory> Snapshots;
    public:
        Engine(const ConfigurationName& configuration_name);

        [[noreturn]] void run_forever(double delay=3);
    private:
        ParserWrappers parser_wrappers;
        Rules rules;
        Snapshots snapshots;
    };
}


#endif //APRILONEIL_ENGINE_H

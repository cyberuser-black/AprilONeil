//
// Created by cyber on 11/3/21.
//

#ifndef APRILONEIL_RULE_H
#define APRILONEIL_RULE_H

#include "../../types.h"
#include "../conditions/ConditionWrapper.h"
#include "../actions/ActionWrapper.h"

namespace apriloneil {
    class Rule {
    public:
        Rule(const ParserWrapper* parser, const ConditionWrapper* condition, const ActionWrapper* action) : parser_id(parser->id), condition(condition), action(action){}

    public:
        void run(const ParserWrapper::ParseHistory& parse_history) const;
        const ParserId parser_id;

    private:
        const ConditionWrapper* condition;
        const ActionWrapper* action;
    };
}


#endif //APRILONEIL_RULE_H

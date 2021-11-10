//
// Created by cyber on 11/3/21.
//

#ifndef APRILONEIL_RULE_H
#define APRILONEIL_RULE_H

#include "../types.h"
#include "../conditions/ICondition.h"
#include "../actions/IAction.h"

namespace apriloneil {
    class Rule {
    public:
        Rule(const ParserWrapper* parser_wrapper, const ICondition* condition, const IAction* action) : parser_id(parser_wrapper->id), condition(condition), action(action){}

    public:
        void run(const ParserWrapper::ParseHistory& parse_history) const;
        const ParserId parser_id;

    private:
        const ICondition* condition;
        const IAction* action;
    };
}


#endif //APRILONEIL_RULE_H

//
// Created by cyber on 11/3/21.
//

#ifndef APRILONEIL_RULE_H
#define APRILONEIL_RULE_H

#include "../../types.h"
#include "../conditions/ConditionWrapper.h"
#include "../actions/ActionWrapper.h"
#include "../../DataAccess.h"

namespace apriloneil {
    class Rule {
    public:
        Rule(const ConditionWrapper* condition, const ActionWrapper* action) : _condition(condition), _action(action){}

    public:
        void run(DataAccess *data_access) const;

    private:
        const ConditionWrapper* _condition;
        const ActionWrapper* _action;
    };
}


#endif //APRILONEIL_RULE_H

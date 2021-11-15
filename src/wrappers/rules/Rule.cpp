//
// Created by cyber on 11/3/21.
//

#include <iostream>
#include "Rule.h"

namespace apriloneil {
    void Rule::run(const ParserWrapper::ParseHistory &parse_history) const {
        std::cout << "[C++] [Rule] Evaluating '" << condition->name() << "'..." << std::endl;
        bool result = condition->evaluate(parse_history);
        std::cout << "[C++] [Rule] Result = " << result << std::endl;
        if (result){
            std::cout << "[C++] [Rule] Condition holds! Performing '" << action->name() << "'..." << std::endl;
            action->do_action(parse_history);
        }
        else{
            std::cout << "[C++] [Rule] Condition does NOT hold." << std::endl;
        }
    }
}


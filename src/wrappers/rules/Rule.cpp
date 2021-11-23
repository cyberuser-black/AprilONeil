//
// Created by cyber on 11/3/21.
//

#include <iostream>
#include "Rule.h"

namespace apriloneil {
    void Rule::run(apriloneil::DataAccess *data_access) const {
        std::cout << "[C++] [Rule] Evaluating '" << _condition->name() << "'..." << std::endl;
        bool result = _condition->evaluate();
        std::cout << "[C++] [Rule] Result = " << result << std::endl;
        if (result){
            std::cout << "[C++] [Rule] Condition holds! Performing '" << _action->name() << "'..." << std::endl;
            _action->do_action();
        }
        else{
            std::cout << "[C++] [Rule] Condition does NOT hold." << std::endl;
        }
    }
}


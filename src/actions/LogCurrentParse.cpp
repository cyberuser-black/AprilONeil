//
// Created by cyber on 11/3/21.
//

#include <iostream>
#include "LogCurrentParse.h"

void apriloneil::LogCurrentParse::do_action(apriloneil::ParserWrapper::ParseHistory history) const {
    std::cout << "[C++] [Action] LogCurrentParse(" << history.second.dump() << ")" << std::endl;
}

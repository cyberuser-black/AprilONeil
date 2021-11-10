//
// Created by cyber on 11/3/21.
//

#include "IsNoChange.h"

namespace apriloneil{
    bool IsNoChange::evaluate(const ParserWrapper::ParseHistory &parsed_history) const {
        return parsed_history.first == parsed_history.second;
    }
}

//
// Created by cyber on 11/3/21.
//

#ifndef APRILONEIL_ISNOCHANGE_H
#define APRILONEIL_ISNOCHANGE_H

#include "ICondition.h"

namespace apriloneil {
    class IsNoChange : public ICondition {
    public:
        bool evaluate(const ParserWrapper::ParseHistory& parsed_history) const override;
    };
}


#endif //APRILONEIL_ISNOCHANGE_H

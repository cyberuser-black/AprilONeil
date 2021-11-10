//
// Created by cyber on 11/3/21.
//

#ifndef APRILONEIL_ICONDITION_H
#define APRILONEIL_ICONDITION_H


#include "../types.h"
#include "../parsers/ParserWrapper.h"

namespace apriloneil {
    class ICondition {
    public:
        virtual bool evaluate(const ParserWrapper::ParseHistory& parsed_history) const = 0;
        virtual std::string name() const = 0;
    };
}


#endif //APRILONEIL_ICONDITION_H

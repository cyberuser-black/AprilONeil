//
// Created by cyber on 11/3/21.
//

#ifndef APRILONEIL_IACTION_H
#define APRILONEIL_IACTION_H

#include "../parsers/ParserWrapper.h"

namespace apriloneil {
    class IAction {
    public:
        virtual void do_action(const ParserWrapper::ParseHistory& history) const = 0;
        virtual std::string name() const = 0;
    };
}

#endif //APRILONEIL_IACTION_H

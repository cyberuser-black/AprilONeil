//
// Created by cyber on 11/3/21.
//

#ifndef APRILONEIL_LOGCURRENTPARSE_H
#define APRILONEIL_LOGCURRENTPARSE_H


#include "IAction.h"
#include "../parsers/ParserWrapper.h"

namespace apriloneil {
    class LogCurrentParse : public IAction {
        void do_action(ParserWrapper::ParseHistory history) const;
    };
}


#endif //APRILONEIL_LOGCURRENTPARSE_H

//
// Created by cyber on 11/8/21.
//

#ifndef APRILONEIL_ACTIONWRAPPER_H
#define APRILONEIL_ACTIONWRAPPER_H

#include "../../types.h"
#include "../parsers/ParserWrapper.h"

namespace apriloneil {
    class ActionWrapper {
    public:
        ActionWrapper(PathToLuaAction lua_action_path) : path(lua_action_path) {};

        void do_action(const ParserWrapper::ParseHistory &parsed_history) const;

        std::string name() const;

    private:
        PathToLuaAction path;
    };
};


#endif //APRILONEIL_ACTIONWRAPPER_H

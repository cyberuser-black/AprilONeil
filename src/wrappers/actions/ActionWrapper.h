//
// Created by cyber on 11/8/21.
//

#ifndef APRILONEIL_ACTIONWRAPPER_H
#define APRILONEIL_ACTIONWRAPPER_H

#include "../../types.h"
#include "../data_sources/parsers/ParserWrapper.h"

namespace apriloneil {
    class ActionWrapper {
    public:
        ActionWrapper(PathToLuaAction lua_action_path) : _lua_action_path(lua_action_path) {};

        void do_action() const;

        std::string name() const;

    private:
        PathToLuaAction _lua_action_path;
    };
};


#endif //APRILONEIL_ACTIONWRAPPER_H

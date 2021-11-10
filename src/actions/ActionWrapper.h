//
// Created by cyber on 11/8/21.
//

#ifndef APRILONEIL_ACTIONWRAPPER_H
#define APRILONEIL_ACTIONWRAPPER_H

#include "IAction.h"

namespace apriloneil {
    class ActionWrapper : public IAction {
    public:
        ActionWrapper(PathToLuaAction lua_action_path) : path(lua_action_path) {};

        void do_action(const ParserWrapper::ParseHistory &parsed_history) const override;

        std::string name() const;

    private:
        PathToLuaAction path;
    };
};


#endif //APRILONEIL_ACTIONWRAPPER_H

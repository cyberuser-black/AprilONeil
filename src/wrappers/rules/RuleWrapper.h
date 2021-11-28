//
// Created by cyber on 11/3/21.
//

#ifndef APRILONEIL_RULEWRAPPER_H
#define APRILONEIL_RULEWRAPPER_H

#include "../../types.h"
#include "../LuaWrapper.h"


namespace apriloneil {
    class RuleWrapper {
    public:
        explicit RuleWrapper(const PathToLuaRule &path) : path(path), id(path.substr(0, path.find_last_of('.'))){}

    public:
        void invoke_rule() const;

        std::string name() const;



    private:
        const PathToLuaRule path;
        const RuleName id;

        void invoke_lua_wrapper() const;

    };
}


#endif //APRILONEIL_RULEWRAPPER_H

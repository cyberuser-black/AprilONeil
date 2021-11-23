//
// Created by cyber on 11/8/21.
//

#ifndef APRILONEIL_CONDITIONWRAPPER_H
#define APRILONEIL_CONDITIONWRAPPER_H

#include "../../types.h"
#include "../data_sources/parsers/ParserWrapper.h"

namespace apriloneil {
    class ConditionWrapper {
    public:
        ConditionWrapper(PathToLuaCondition lua_condition_path) : _lua_condition_path(lua_condition_path){};
        bool evaluate() const;
        std::string name() const;

    private:
        PathToLuaCondition _lua_condition_path;
    };
};

#endif //APRILONEIL_CONDITIONWRAPPER_H

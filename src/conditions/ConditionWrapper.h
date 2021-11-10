//
// Created by cyber on 11/8/21.
//

#ifndef APRILONEIL_CONDITIONWRAPPER_H
#define APRILONEIL_CONDITIONWRAPPER_H

#include "ICondition.h"

namespace apriloneil {
    class ConditionWrapper : public ICondition{
    public:
        ConditionWrapper(PathToLuaCondition lua_condition_path) : path(lua_condition_path){};
        bool evaluate(const ParserWrapper::ParseHistory &parsed_history) const override;
        std::string name() const;

    private:
        PathToLuaCondition path;
    };
};

#endif //APRILONEIL_CONDITIONWRAPPER_H

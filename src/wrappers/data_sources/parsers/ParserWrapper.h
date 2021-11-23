//
// Created by cyber on 11/3/21.
//

#ifndef APRILONEIL_PARSERWRAPPER_H
#define APRILONEIL_PARSERWRAPPER_H

#include <utility>
#include "../DataSourceInterface.h"
#include "../../../types.h"

namespace apriloneil {
    class ParserWrapper : public DataSourceInterface {
    public:
        explicit ParserWrapper(const PathToLuaParser& path) : _lua_parser_path(path), _id(path.substr(0, path.find_last_of('.'))) {};

    public:
        void get_data(Data* out_data) const override;
        std::string name() const override;
        const DataSourceID & get_id() const override;

    private:
        void invoke_lua_wrapper(Data *out_parsed_data) const;

    private:
        const DataSourceID _id;
        const PathToLuaParser _lua_parser_path;
    };
}


#endif //APRILONEIL_PARSERWRAPPER_H

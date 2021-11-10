//
// Created by cyber on 11/3/21.
//

#ifndef APRILONEIL_PARSERWRAPPER_H
#define APRILONEIL_PARSERWRAPPER_H

#include <utility>
#include "../types.h"

namespace apriloneil {
    class ParserWrapper {
    public:
        typedef std::pair<ParsedData, ParsedData> ParseHistory;

        explicit ParserWrapper(const PathToLuaParser path) : path(path), id(path.substr(0, path.find_last_of('.'))) {};

    public:
        const ParseHistory &invoke();
        std::string name() const;

        const ParserId id;
    private:
        ParseHistory history;
        const PathToLuaParser path;

        static void invoke_lua_parser(ParsedData *out_parsed_data);

        static void invoke_lua_selene(ParsedData *out_parsed_data);

        void invoke_lua_wrapper(ParsedData *out_parsed_data);
    };
}


#endif //APRILONEIL_PARSERWRAPPER_H

//
// Created by cyber on 11/15/21.
//

#ifndef APRILONEIL_ROOTAPI_H
#define APRILONEIL_ROOTAPI_H

#include <fstream>
#include <sstream>

namespace apriloneil {
    class RootAPI {
    public:
        static std::string readfile(const std::string &path) {
            std::cout << "[C++] [RootAPI] [readfile] reading " << path << "..." << std::endl;
            std::ifstream t(path);
            std::stringstream buffer;
            buffer << t.rdbuf();
            std::cout << "[C++] [RootAPI] [readfile] \"" << buffer.str() << "\"" << std::endl;
            return buffer.str();
        }
    };
}
#endif //APRILONEIL_ROOTAPI_H

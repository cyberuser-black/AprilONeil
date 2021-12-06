//
// Created by cyber on 12/6/21.
//
#include <iostream>
#include <dirent.h>
#include "utils.h"

namespace apriloneil {
    inline bool ends_with(std::string const & value, std::string const & ending)
    {
        if (ending.size() > value.size()) return false;
        return std::equal(ending.rbegin(), ending.rend(), value.rbegin());
    }

    int list_dir(const std::string &path, std::vector<std::string>* out_files) {
        return list_dir_ending_with(path, "", out_files);
    }

    int list_dir_ending_with(const std::string &path, const std::string &ending, std::vector<std::string>* out_files) {
        if (not out_files->empty()){
            std::cout << "[C++] [list_dir] Error: out_files is not empty!" << std::endl;
            return -1;
        }
        struct dirent *entry;
        DIR *dp;

        dp = ::opendir(path.c_str());
        if (dp == NULL) {
            std::cout << "[C++] [list_dir] Error: opendir: Path '" << path << "' does not exist or could not be read." << std::endl;
            return -1;
        }

        while ((entry = ::readdir(dp))) {
            auto filename = std::string(entry->d_name);
            if (ends_with(filename, ending)){
                std::cout << "[C++] [utils] adding file '" << entry->d_name << "'..." << std::endl;
                out_files->push_back(std::string(path + "/" + entry->d_name));
            }
            else{
                std::cout << "[C++] [utils] skipping file '" << filename << "'..." << std::endl;
            }
        }

        ::closedir(dp);
        return 0;
    }
}
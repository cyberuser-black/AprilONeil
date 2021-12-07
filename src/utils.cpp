//
// Created by cyber on 12/6/21.
//
#include <iostream>
#include <dirent.h>
#include "utils.h"
#include "tracing/trace_entry.h"

namespace apriloneil {
    inline bool ends_with(std::string const &value, std::string const &ending) {
        if (ending.size() > value.size()) return false;
        return std::equal(ending.rbegin(), ending.rend(), value.rbegin());
    }

    int list_dir(const std::string &path, std::vector<std::string> *out_files) {
        return list_dir_ending_with(path, "", out_files);
    }

    int list_dir_ending_with(const std::string &path, const std::string &ending, std::vector<std::string> *out_files) {
        TRACE_ENTER();
        if (not out_files->empty()) {
            TRACE_MESSAGE("Error: out_files is not empty!");
            return -1;
        }
        struct dirent *entry;
        DIR *dp;

        dp = ::opendir(path.c_str());
        if (dp == NULL) {
            TRACE_MESSAGE("Error: opendir: Path '" + path + "' does not exist or could not be read.");
            return -1;
        }

        while ((entry = ::readdir(dp))) {
            auto filename = std::string(entry->d_name);
            if (ends_with(filename, ending)) {
                TRACE_MESSAGE("adding file '" + std::string(entry->d_name) + "'...");
                out_files->push_back(std::string(path + "/" + entry->d_name));
            } else {
                TRACE_MESSAGE("skipping file '" + filename + "'...");
            }
        }

        ::closedir(dp);
        return 0;
    }
}
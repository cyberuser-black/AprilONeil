//
// Created by cyber on 12/7/21.
//

#ifndef APRILONEIL_TRACE_LOG_H
#define APRILONEIL_TRACE_LOG_H

#include <string>
#include <vector>
#include "colormod.h"

namespace apriloneil {
    class TraceEntry;

    class TraceLog {
        typedef std::vector<std::pair<const std::string, const color::Code>> Indentations;

    public:
        static TraceLog &get_instance() {
            static TraceLog instance;
            return instance;
        }

    private:
        TraceLog() {}

        // noncopyable so we don't accidentally copy it
        TraceLog(TraceLog &) = delete;

        void operator=(TraceLog) = delete;

        friend TraceEntry;

        Indentations indentations;
    };
}

#endif //APRILONEIL_TRACE_LOG_H

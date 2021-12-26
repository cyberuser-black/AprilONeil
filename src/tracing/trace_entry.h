//
// Created by cyber on 12/7/21.
//

#ifndef APRILONEIL_TRACE_ENTRY_H
#define APRILONEIL_TRACE_ENTRY_H

#include "trace_log.h"
#include <string>
#include <string.h>

#include "colormod.h" // namespace color
#include <iostream>

#ifndef __FUNCTION_NAME__
#ifdef WIN32   //WINDOWS
#define __FUNCTION_NAME__   __FUNCTION__
#else          //*NIX
#define __FUNCTION_NAME__   __func__
#endif
#endif
#define __FILE_NAME__ (strrchr(__FILE__, '/') ? strrchr(__FILE__, '/') + 1 : __FILE__)

#define COLOR_CPP color::FG_RED
#define COLOR_LUA color::FG_GREEN
#define TRACE_ENTER()  apriloneil::TraceEntryCPP trace_created_with_TRACE_ENTER(__FILE_NAME__, __FUNCTION_NAME__)
#define TRACE(message)  apriloneil::TraceEntryCPP(__FILE_NAME__, __FUNCTION_NAME__).trace(message)
#define TRACE_MESSAGE(message) trace_created_with_TRACE_ENTER.trace(message)
#define TRACE_LUA() apriloneil::TraceEntryLua trace_created_with_TRACE_LUA(__FILE_NAME__, __FUNCTION_NAME__)
#define TRACE_LUA_MESSAGE(message) trace_created_with_TRACE_LUA.trace(message)

namespace apriloneil {

    class TraceEntry {
    public:
        TraceEntry(color::Code color_code,
                   const std::string &file_name,
                   const std::string &function_name,
                   const std::string &message="");

        ~TraceEntry();

        void trace(const std::string &message);

    protected:
        // noncopyable so we don't accidentally copy it
        TraceEntry(TraceEntry &);

        void operator=(TraceEntry);

        void _prefix(const std::string &connector);

        void _trace(const std::string &connector, const std::string &message);

        bool verbose_exit_;
        TraceLog &log_;
        std::string file_name_;
        std::string function_name_;
        std::string frame_;
        color::Code color_code_;
    };

    class TraceEntryCPP : public TraceEntry {
    public:
        TraceEntryCPP(const std::string &file_name, const std::string &function_name) : TraceEntry(COLOR_CPP, file_name,
                                                                                                   function_name) {};
    };

    class TraceEntryLua : public TraceEntry {
    public:
        TraceEntryLua(const std::string &file_name, const std::string &function_name) : TraceEntry(COLOR_LUA, file_name,
                                                                                                   function_name) {};
    };
}

#endif //APRILONEIL_TRACE_ENTRY_H

//
// Created by cyber on 12/7/21.
//

#include <iostream>
#include <iomanip>
#include "trace_entry.h"

apriloneil::TraceEntry::TraceEntry(color::Code color_code, const std::string &file_name,
                                   const std::string &function_name) : log_(TraceLog::get_instance()),
                                                                       file_name_(file_name),
                                                                       function_name_(function_name),
                                                                       color_code_(color_code) {
    auto indentation = std::pair<const std::string, const color::Code>("|    ", color_code);
    log_.indentations.push_back(indentation);
    _trace("├───", "ENTER");
}

apriloneil::TraceEntry::~TraceEntry() {
    _trace("└───", "EXIT");
    log_.indentations.pop_back();
}

void apriloneil::TraceEntry::trace(const std::string &message) {
    _trace("├───", message);
}

void apriloneil::TraceEntry::_trace(const std::string &connector, const std::string &message) {
    _prefix(connector);
    std::cout << message << std::endl;
}

void apriloneil::TraceEntry::_prefix(const std::string &connector) {
    std::cout << std::left;
    for (auto indentation: log_.indentations) {
        auto indent_str = indentation.first;
        auto color = color::Modifier(indentation.second);
        std::cout << color << indent_str;
    }
    std::cout << color::Modifier(color_code_) << connector << " [" << file_name_ << " : " << function_name_ << "] "
              << color::Modifier(color::FG_DEFAULT) << color::Modifier(color::BG_DEFAULT);
}
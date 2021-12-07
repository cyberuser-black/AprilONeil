//
// Created by silver on 23/11/2021.
//

#include "action.h"
#include "iostream"
#include "../tracing/trace_entry.h"
#include <utility>

void Action::log(const std::string &str) {
    TRACE_ENTER();
    TRACE_MESSAGE("Log Input: " + str);
}

void Action::invoke_action(int actionNum, const std::string &input) {
    switch (actionNum) {
        case LOG_ACTION:
            log(input);
            break;
        default:
            printf("Illegal action number!\n");
    }
}

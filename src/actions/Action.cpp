//
// Created by silver on 23/11/2021.
//

#include "Action.h"
#include "iostream"
#include <utility>

void Action::log(const std::string &str) {
    std::cout << "[C++] [Log Action] Log Input: " << str << std::endl;
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

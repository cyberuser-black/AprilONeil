//
// Created by silver on 23/11/2021.
//

#ifndef APRILONEIL_ACTION_H
#define APRILONEIL_ACTION_H


#include <string>

enum {LOG_ACTION};

class Action {
public:
    static void invoke_action(int actionNum, const std::string &input);

private:
    Action() {}
    static void log(const std::string &str);};


#endif //APRILONEIL_ACTION_H

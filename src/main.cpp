#include <iostream>

#include "engine.h"
#include "tracing/trace_entry.h"

int main() {
    TRACE_ENTER();
    apriloneil::Engine engine("default.txt");
    engine.run_forever();
    return 0;
}



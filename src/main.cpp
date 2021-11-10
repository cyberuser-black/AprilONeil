#include <iostream>

#include "Engine.h"

int main() {
    apriloneil::Engine engine("default.txt");
    engine.run_forever();
    return 0;
}

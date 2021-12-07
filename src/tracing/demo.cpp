//
// Created by cyber on 12/7/21.
//

#include "trace_log.h"
#include "trace_entry.h"

namespace apriloneil {
    void a() {
        TRACE_ENTER();
    }

    void b() {
        TRACE_ENTER();
        return a();
    }

    int main() {
        TRACE_ENTER();
        b();
        return 0;
    }
}
//
// Created by cyber on 11/23/21.
//

#include <iostream>
#include "data_entry.h"
#include "tracing/trace_entry.h"

const apriloneil::DataHistory &apriloneil::DataEntry::get_data() {
    TRACE_ENTER();
    TRACE_MESSAGE("Getting data... ");
    clock_t now = clock();
    // DataEntries entry expired? Access Data
    //TRACE_MESSAGE("now = " + now + ", _last_updated = " + _last_updated + ", ttl = " + _ttl_milisec);
    if (_ttl_milisec < (now - _last_updated)) {
        TRACE_MESSAGE("DataEntry is old, calling the data source... ");
        auto *new_data = new Data();
        _data_source->get_data(new_data);
        TRACE_MESSAGE("New data = '" + new_data->dump() + "'");
        delete _cached_data->second;
        _cached_data->second = _cached_data->first;
        _cached_data->first = new_data;
        _last_updated = now;
    } else {
        TRACE_MESSAGE("DataEntry still fresh, returning from cache... ");
    }
    return *_cached_data;
}

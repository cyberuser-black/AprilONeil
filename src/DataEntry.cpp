//
// Created by cyber on 11/23/21.
//

#include <iostream>
#include "DataEntry.h"

const apriloneil::DataHistory &apriloneil::DataEntry::get_data() {
    std::cout << "[C++] [DataEntry] Getting data... " << std::endl;
    clock_t now = clock();
    // DataEntries entry expired? Access Data
    std::cout << "[C++] [DataEntry] now = " << now << ", _last_updated = " << _last_updated << ", ttl = " << _ttl_milisec << std::endl;
    if (_ttl_milisec < (now - _last_updated)) {
        std::cout << "[C++] [DataEntry] DataEntry is old, calling the data source... " << std::endl;
        auto *new_data = new Data();
        _data_source->get_data(new_data);
        std::cout << "[C++] [DataEntry] New data = '" << new_data->dump() << "'" << std::endl;
        delete _cached_data->second;
        _cached_data->second = _cached_data->first;
        _cached_data->first = new_data;
        _last_updated = now;
    } else {
        std::cout << "[C++] [DataEntry] DataEntry still fresh, returning from cache... " << std::endl;
    }
    return *_cached_data;
}

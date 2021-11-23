//
// Created by cyber on 11/23/21.
//

#ifndef APRILONEIL_DATAENTRY_H
#define APRILONEIL_DATAENTRY_H

#include "types.h"
#include "wrappers/data_sources/DataSourceInterface.h"

namespace apriloneil {
    class DataEntry {
    public:
        DataEntry(DataSourceInterface* data_source, clock_t ttl_milisec) :
                _ttl_milisec(ttl_milisec),
                _last_updated(-1),
                _data_source(data_source),
                _cached_data(new DataHistory(new Data("UNINITIALIZED"), new Data("UNINITIALIZED"))) {};

        const DataHistory &get_data();

    private:
        DataHistory* _cached_data;
        clock_t _last_updated;
        clock_t _ttl_milisec;
        const DataSourceInterface *_data_source;
    };
}


#endif //APRILONEIL_DATAENTRY_H

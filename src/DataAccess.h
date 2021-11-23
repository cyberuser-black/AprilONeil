//
// Created by cyber on 11/23/21.
//

#ifndef APRILONEIL_DATAACCESS_H
#define APRILONEIL_DATAACCESS_H


#include <string>
#include <unordered_map>
#include <vector>
#include "types.h"
#include "wrappers/data_sources/DataSourceInterface.h"
#include "DataEntry.h"

namespace apriloneil {
    class DataAccess {
    public:
        typedef std::unordered_map<DataSourceID, DataEntry*> DataEntries;

    private:
        explicit DataAccess() {};

    public:

        // Singletons should not be cloneable.
        DataAccess(DataAccess &other) = delete;

        // Singletons should not be assignable.
        void operator=(const DataAccess &) = delete;

        // Accessor to the singleton object.
        static DataAccess *GetInstance();

        static JSONStr get_data_current(const DataSourceID &data_source_id);

    private:
        static DataAccess *_data_access;
        static DataEntries *_data_entries;
    };
}
#endif //APRILONEIL_DATAACCESS_H

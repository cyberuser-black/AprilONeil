//
// Created by cyber on 11/23/21.
//

#include <iostream>
#include "DataAccess.h"
#include "wrappers/data_sources/parsers/ParserWrapper.h"

namespace apriloneil {
    DataAccess *DataAccess::_data_access = nullptr;
    DataAccess::DataEntries *DataAccess::_data_entries = nullptr;

    DataAccess *DataAccess::GetInstance() {
        if (DataAccess::_data_access == nullptr) {
            DataAccess::_data_access = new DataAccess();
            DataAccess::_data_entries = new DataEntries();
        }
        return nullptr;
    }

    JSONStr DataAccess::get_data_current(const DataSourceID &data_source_id) {
        std::cout << "[C++] [DataAccess] get_data_current('" << data_source_id << "')..." << std::endl;
        std::cout << "[C++] [DataAccess] validating data source exists..." << std::endl;
        // Does data source exist yet?
        if (DataAccess::_data_entries->find(data_source_id) == DataAccess::_data_entries->end()) {
            // No - create it!
            std::cout << "[C++] [DataAccess] data source does not exist!" << std::endl;
            // TODO: Determine what type of data source to create
            auto data_source = new ParserWrapper(data_source_id);
            auto data_entry = new DataEntry(data_source, 7000);
            (*DataAccess::_data_entries)[data_source_id] = data_entry;
        }
        auto data_history = (*DataAccess::_data_entries)[data_source_id]->get_data();
        std::cout << "[C++] [DataAccess] returning current data '" << data_history.first->dump() << "'"
                  << std::endl;
        return data_history.first->dump();
    }
}

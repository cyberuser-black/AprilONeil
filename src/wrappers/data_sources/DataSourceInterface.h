//
// Created by cyber on 11/22/21.
//

#ifndef APRILONEIL_DATASOURCEINTERFACE_H
#define APRILONEIL_DATASOURCEINTERFACE_H


#include <utility>
#include "../../types.h"

namespace apriloneil {
    class DataSourceInterface {

    public:
        virtual void get_data(Data* out_data) const = 0;
        virtual std::string name() const = 0;
        virtual const DataSourceID & get_id() const = 0;
    };
}


#endif //APRILONEIL_DATASOURCEINTERFACE_H

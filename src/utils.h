#include <string>
#include <vector>

namespace apriloneil {
    inline bool ends_with(std::string const & value, std::string const & ending);
    int list_dir(const std::string &path, std::vector<std::string>* out_files);
    int list_dir_ending_with(const std::string &path, const std::string & ending, std::vector<std::string>* out_files);
}
print("[Lua] [/proc/<pid>/stat] running...")

-- Add {PROJECT_DIR}/lua to LUA_PATH (assuming executable runs in {PROJECT_DIR}/cmake-build-debug)
package.path = package.path .. ";./lua/?.lua"
local cyberlib = require ('cyberlib') -- from {PROJECT_DIR}/lua/cyberlib.lua



stat_key_table = {
    [1] = {"pid", tonumber},
    [2] = {"comm", cyberlib.lambdas.id},
    [3] = {"state", cyberlib.lambdas.id},
    [4] = {"ppid", tonumber},
    [5] = {"pgrp", tonumber},
    [6] = {"session", tonumber},
    [7] = {"tty_nr", tonumber},
    [8] = {"tpgid", tonumber},
    [9] = {"flags", tonumber},
    [10] = {"minflt", tonumber},
    [11] = {"cminflt", tonumber},
    [12] = {"majflt", tonumber},
    [13] = {"cmajflt", tonumber},
    [14] = {"utime", tonumber},
    [15] = {"stime", tonumber},
    [16] = {"cutime", tonumber},
    [17] = {"cstime", tonumber},
    [18] = {"priority", tonumber},
    [19] = {"nice", tonumber},
    [20] = {"num_threads", tonumber},
    [21] = {"itrealvalue", tonumber},
    [22] = {"starttime", tonumber},
    [23] = {"vsize", tonumber},
    [24] = {"rss", tonumber},
    [25] = {"rsslim", tonumber},
    [26] = {"startcode", tonumber},
    [27] = {"endcode", tonumber},
    [28] = {"startstack", tonumber},
    [29] = {"kstkesp", tonumber},
    [30] = {"kstkeip", tonumber},
    [31] = {"signal", tonumber},
    [32] = {"blocked", tonumber},
    [33] = {"sigignore", tonumber},
    [34] = {"sigcatch", tonumber},
    [35] = {"wchan", tonumber},
    [36] = {"nswap", tonumber},
    [37] = {"cnswap", tonumber},
    [38] = {"exit_signal", tonumber},
    [39] = {"processor", tonumber},
    [40] = {"rt_priority", tonumber},
    [41] = {"policy", tonumber},
    [42] = {"delayacct_blkio_ticks", tonumber},
    [43] = {"guest_time", tonumber},
    [44] = {"cguest_time", tonumber},
    [45] = {"start_data", tonumber},
    [46] = {"end_data", tonumber},
    [47] = {"start_brk", tonumber},
    [48] = {"arg_start", tonumber},
    [49] = {"arg_end", tonumber},
    [50] = {"env_start", tonumber},
    [51] = {"env_end", tonumber},
    [52] = {"exit_code", tonumber}
}

name = "stat"

function parse(data)
    parsed_data_with_keys = {}
    print("[Lua] [/proc/<pid>/stat] parse() "..name.."...")
    local parsed_data = cyberlib.parsers_helpers.parse_lines_to_lists_of_lists(data)
    for k, v in pairs(parsed_data[1]) do
        print(k, v)
        parsed_data_with_keys[stat_key_table[k][1]] = (stat_key_table[k][2])(v)
    end
    return parsed_data_with_keys
end

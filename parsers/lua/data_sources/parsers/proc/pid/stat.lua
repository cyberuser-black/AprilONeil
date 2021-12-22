print("[Lua] [/proc/<pid>/stat] running...")

-- Add {PROJECT_DIR}/lua to LUA_PATH (assuming executable runs in {PROJECT_DIR}/cmake-build-debug)
package.path = package.path .. ";./lua/?.lua"
local cyberlib = require ('cyberlib') -- from {PROJECT_DIR}/lua/cyberlib.lua

stat_key_table = {
    [1] = "pid",
    [2] = "comm",
    [3] = "state",
    [4] = "ppid",
    [5] = "pgrp",
    [6] = "session",
    [7] = "tty_nr",
    [8] = "tpgid",
    [9] = "flags",
    [10] = "minflt",
    [11] = "cminflt",
    [12] = "majflt",
    [13] = "cmajflt",
    [14] = "utime",
    [15] = "stime",
    [16] = "cutime",
    [17] = "cstime",
    [18] = "priority",
    [19] = "nice",
    [20] = "num_threads",
    [21] = "itrealvalue",
    [22] = "starttime",
    [23] = "vsize",
    [24] = "rss",
    [25] = "rsslim",
    [26] = "startcode",
    [27] = "endcode",
    [28] = "startstack",
    [29] = "kstkesp",
    [30] = "kstkeip",
    [31] = "signal",
    [32] = "blocked",
    [33] = "sigignore",
    [34] = "sigcatch",
    [35] = "wchan",
    [36] = "nswap",
    [37] = "cnswap",
    [38] = "exit_signal",
    [39] = "processor",
    [40] = "rt_priority",
    [41] = "policy",
    [42] = "delayacct_blkio_ticks",
    [43] = "guest_time",
    [44] = "cguest_time",
    [45] = "start_data",
    [46] = "end_data",
    [47] = "start_brk",
    [48] = "arg_start",
    [49] = "arg_end",
    [50] = "env_start",
    [51] = "env_end",
    [52] = "exit_code"
}

name = "stat"

function parse(data)
    parsed_data_with_keys = {}
    print("[Lua] [/proc/<pid>/stat] parse() "..name.."...")
    local parsed_data = cyberlib.parsers_helpers.parse_lines_to_lists_of_lists(data)
    for k, v in pairs(parsed_data[1]) do
        parsed_data_with_keys[stat_key_table[k]] = v
--         print(stat_key_table[k], v)
    end
    return parsed_data_with_keys
end

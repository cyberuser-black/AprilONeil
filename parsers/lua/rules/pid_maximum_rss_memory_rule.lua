package.path = package.path .. ";./lua/?.lua"

local cyberlib = require ('cyberlib') -- from {PROJECT_DIR}/lua/cyberlib.lua
-- local status_parser = require( './lua/data_sources/parsers/proc/pid/status')

print("[Lua] [pid_maximum_rss_memory_rule] required...")
-- function pre_run()
--     print("[Lua] [pid_maximum_rss_memory_rule] pre-running...")
--     --check {'/proc/pid/status'}
--     return true
-- end

local default_max_rss = 1000 -- in KB

-- default_exe = '/usr/bin/bash' -- for linux
local default_exe = '/bin/dash' -- for windows with wsl

function run(pid, max_rss)
    if max_rss == nil then
        max_rss = default_max_rss
    end
    parsed_data = cyberlib.temp.get_data('/proc/' .. pid .. '/status', cyberlib.temp.root_api_operations.OPEN)
    if parsed_data == nil then
        print('[Lua] [pid_maximum_rss_memory_rule] [action] data is not ready for /proc/' .. pid .. '/status.')
        return
    end
    local vmrss_table = parsed_data['VmRSS']
    if vmrss_table == nil then
        return
    end
    parsed_data_rss = vmrss_table[1]
    if parsed_data_rss > max_rss then
        print('[Lua] [pid_maximum_rss_memory_rule] [action] VmRSS memory anomaly detected! Expected less than ' .. max_rss .. ', got ' .. parsed_data_rss)
    end
end
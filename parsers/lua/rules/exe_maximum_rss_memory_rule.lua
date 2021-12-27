package.path = package.path .. ";./lua/?.lua"

local cyberlib = require ('cyberlib') -- from {PROJECT_DIR}/lua/cyberlib.lua
-- local status_parser = require( './lua/data_sources/parsers/proc/pid/status')

print("[Lua] [exe_maximum_rss_memory_rule] required...")
-- function pre_run()
--     print("[Lua] [exe_maximum_rss_memory_rule] pre-running...")
--     --check {'/proc/pid/status'}
--     return true
-- end

local default_max_rss = 1000 -- in KB

-- local default_exe = '/usr/bin/bash' -- for linux
local default_exe = '/bin/dash' -- for windows with wsl

function run(exe, max_rss, exes_pids)
    if exe == nil then
        exe = default_exe
    end
    if max_rss == nil then
        max_rss = default_max_rss
    end
    if exes_pids == nil then
        exe_pids = cyberlib.rules_helpers.get_exe_pids()
    else
        exe_pids = exes_pids
    end
    local pids = exe_pids[exe]
    if pids == nil then
        print('[Lua] [exe_maximum_rss_memory_rule] [action] no pids for exe ' .. exe .. '.')
        return
    end
    for i=1, #pids do
        parsed_data = cyberlib.temp.get_data('/proc/' .. pids[i] .. '/status', cyberlib.temp.root_api_operations.OPEN)
        if parsed_data == nil then
            print('[Lua] [exe_maximum_rss_memory_rule] [action] data is not ready for /proc/' .. pids[i] .. '/status.')
            goto continue
        end
        local vmrss_table = parsed_data['VmRSS']
        if vmrss_table == nil then
            goto continue
        end
        parsed_data_rss = tonumber(vmrss_table[1])
        if parsed_data_rss > max_rss then
            print('[Lua] [exe_maximum_rss_memory_rule] [action] VmRSS memory anomaly detected! Expected less than ' .. max_rss .. ', got ' .. parsed_data_rss)
        end
        ::continue::
    end
end
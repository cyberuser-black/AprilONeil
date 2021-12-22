package.path = package.path .. ";./lua/?.lua"

local cyberlib = require ('cyberlib') -- from {PROJECT_DIR}/lua/cyberlib.lua
-- local status_parser = require( './lua/data_sources/parsers/proc/pid/status')

print("[Lua] [exe_maximum_rss_memory_rule] running...")
-- function pre_run()
--     print("[Lua] [exe_maximum_rss_memory_rule] pre-running...")
--     --check {'/proc/pid/status'}
--     return true
-- end

default_max_rss = 1000 -- in KB

-- default_exe = '/usr/bin/bash' -- for linux
default_exe = '/bin/dash' -- for windows with wsl

function run(exe, max_rss)
    if exe == nil then
        exe = default_exe
    end
    if max_rss == nil then
        max_rss = default_max_rss
    end

    local exe_pids = cyberlib.rules_helpers.get_exe_pids()
    local pids = exe_pids[exe]
    if pids == nil then
        print('[Lua] [exe_maximum_rss_memory_rule] [action] no pids for exe ' .. exe .. '.')
        return
    end
    for i=1, #pids do
        print(pids[i])
        parsed_data = cyberlib.temp.get_data('/proc/pid/status', 'open', pids[i])
        parsed_data_rss = tonumber(parsed_data['VmRSS'][1])
        if parsed_data_rss > max_rss then
            print('[Lua] [exe_maximum_rss_memory_rule] [action] VmRSS memory deviation detected! Expected less than ' .. max_rss .. ', got ' .. parsed_data_rss)
        end
    end
end

run()
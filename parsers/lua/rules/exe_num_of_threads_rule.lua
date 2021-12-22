package.path = package.path .. ";./lua/?.lua"

local cyberlib = require ('cyberlib') -- from {PROJECT_DIR}/lua/cyberlib.lua
-- local status_parser = require( './lua/data_sources/parsers/proc/pid/status')

print("[Lua] [exe_num_of_threads_rule] running...")
-- function pre_run()
--     print("[Lua] [exe_num_of_threads_rule] pre-running...")
--     --check {'/proc/pid/status'}
--     return true
-- end

default_max_threads = 3 -- in KB

-- default_exe = '/usr/bin/bash' -- for linux
default_exe = '/bin/dash' -- for windows with wsl

function run(exe, max_threads)
    if exe == nil then
        exe = default_exe
    end
    if max_threads == nil then
        max_threads = default_max_threads
    end

    local exe_pids = cyberlib.rules_helpers.get_exe_pids()
    local pids = exe_pids[exe]
    if pids == nil then
        print('[Lua] [exe_num_of_threads_rule] [action] no pids for exe ' .. exe .. '.')
        return
    end
    for i=1, #pids do
        parsed_data = cyberlib.temp.get_data('/proc/pid/status', 'open', pids[i])
        parsed_data_threads = tonumber(parsed_data['Threads'][1])
        if parsed_data_threads > max_threads then
            print('[Lua] [exe_num_of_threads_rule] [action] Too many threads for pid ' .. pids[i] .. '! Expected less than ' .. max_threads .. ', got ' .. parsed_data_threads)
        end
    end
end

run()
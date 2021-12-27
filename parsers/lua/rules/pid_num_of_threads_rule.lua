package.path = package.path .. ";./lua/?.lua"

local cyberlib = require ('cyberlib') -- from {PROJECT_DIR}/lua/cyberlib.lua
-- local status_parser = require( './lua/data_sources/parsers/proc/pid/status')

print("[Lua] [pid_num_of_threads_rule] required...")
function pre_run()
    print("[Lua] [pid_num_of_threads_rule] pre-running...")
    --check {'/proc/pid/status'}
    return true
end

local default_max_threads = 0 -- in KB

--local default_exe = '/usr/bin/bash' -- for linux
local default_exe = '/bin/dash' -- for windows with wsl

function run(pid, max_threads)
    if max_threads == nil then
        max_threads = default_max_threads
    end
    parsed_data = cyberlib.temp.get_data('/proc/' .. pid .. '/status', cyberlib.temp.root_api_operations.OPEN)
    if parsed_data == nil then
        print('[Lua] [pid_num_of_threads_rule] [action] data is not ready for /proc/' .. pid .. '/status.')
        return
    end
    local threads_table = parsed_data['Threads']
    if threads_table == nil then
        return
    end
    parsed_data_threads = tonumber(threads_table[1])
    if parsed_data_threads > max_threads then
        print('[Lua] [pid_num_of_threads_rule] [action] Too many threads for pid ' .. pid .. '! Expected less than ' .. max_threads .. ', got ' .. parsed_data_threads)
    end
end
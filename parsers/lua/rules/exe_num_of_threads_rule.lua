package.path = package.path .. ";./lua/?.lua"

local cyberlib = require ('cyberlib') -- from {PROJECT_DIR}/lua/cyberlib.lua
-- local status_parser = require( './lua/data_sources/parsers/proc/pid/status')

print("[Lua] [exe_num_of_threads_rule] required...")
function pre_run()
    print("[Lua] [exe_num_of_threads_rule] pre-running...")
    --check {'/proc/pid/status'}
    return true
end

local default_max_threads = 0

-- local default_exe = '/usr/bin/bash' -- for linux
local default_exe = '/bin/dash' -- for windows with wsl

function run(exe, max_threads, exes_pids)
    if exe == nil then
        exe = default_exe
    end
    if max_threads == nil then
        max_threads = default_max_threads
    end
    if exes_pids == nil then
        exe_pids = cyberlib.rules_helpers.get_exe_pids()
    else
        exe_pids = exes_pids
    end
    local pids = exe_pids[exe]
    if pids == nil then
        print('[Lua] [exe_num_of_threads_rule] [action] no pids for exe ' .. exe .. '.')
        return
    end
    print("number of bashinstances: " ..#pids)
    for i=1, #pids do
        parsed_data = cyberlib.temp.get_data('/proc/' .. pids[i] .. '/status', cyberlib.temp.root_api_operations.OPEN)
        if parsed_data == nil then
            print('[Lua] [exe_num_of_threads_rule] [action] data is not ready for /proc/' .. pids[i] .. '/status.')
            goto continue
        end
        local threads_table = parsed_data['Threads']
        if threads_table == nil then
            goto continue
        end
        parsed_data_threads = threads_table[1]
        if parsed_data_threads > max_threads then
            print('[Lua] [exe_num_of_threads_rule] [action] Too many threads for pid ' .. pids[i] .. '! Expected less than ' .. max_threads .. ', got ' .. parsed_data_threads)
        end
        ::continue::
    end
end
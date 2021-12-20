package.path = package.path .. ";./lua/?.lua"

local cyberlib = require ('cyberlib') -- from {PROJECT_DIR}/lua/cyberlib.lua
local status_parser = require( './lua/data_sources/parsers/proc/pid/status')

print("[Lua] [bash_root_instances] running...")
function pre_run()
    print("[Lua] [bash_root_instances] pre-running...")
    --check {'/proc/pid/status'}
    return true
end

-- exe = '/usr/bin/bash' -- for linux
exe = '/bin/dash' -- for windows with wsl

max_of_allowed_rooted_terminals = 2

function run()
    print('[Lua] [bash_root_instances] calling cyberlib.get_exe_pids()')
    local exe_pids = cyberlib.get_exe_pids()
    local pids = exe_pids[exe]
    local num_of_rooted_terminals = 0
    if pids == nil then
        print('[Lua] [bash_root_instances] [action] no pids for exe ' .. exe .. '.')
        return
    end
    for i, pid in pairs(pids) do
        parsed_data = parse(pid)
        parsed_data = parsed_data['Uid']
        for j, uid in pairs(parsed_data) do
            if uid == '0' then
                num_of_rooted_terminals = num_of_rooted_terminals + 1
                goto continue
            end
        end
        :: continue ::
    end
    if num_of_rooted_terminals >= max_of_allowed_rooted_terminals then
        print('[Lua] [bash_root_instances] [action] more than ' .. max_of_allowed_rooted_terminals .. ' rooted terminals! ' .. num_of_rooted_terminals .. ' found!')
    else
        print("[Lua] [bash_root_instances] [action] less than " .. max_of_allowed_rooted_terminals .. ' rooted terminals, ' .. num_of_rooted_terminals .. ' found..')
    end
end

run()
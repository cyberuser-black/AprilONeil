package.path = package.path .. ";./lua/?.lua"

local cyberlib = require ('cyberlib') -- from {PROJECT_DIR}/lua/cyberlib.lua
-- local status_parser = require( './lua/data_sources/parsers/proc/pid/status')

print("[Lua] [exe_instances_rule] running...")
-- function pre_run()
--     print("[Lua] [exe_instances_rule] pre-running...")
--     --check {'exe pid list'}
--     return true
-- end

default_max_instances = 5
default_min_instances = 1

-- default_exe = '/usr/bin/bash' -- for linux
default_exe = '/bin/dash' -- for windows with wsl

function run(exe, max_instances, min_instances)
    if exe == nil then
        exe = default_exe
    end
    if max_instances == nil then
        max_instances = default_max_instances
    end
    if min_instances == nil then
        min_instances = default_min_instances
    end
    local exe_pids = cyberlib.rules_helpers.get_exe_pids()
    local pids = exe_pids[exe]
    if pids == nil then
        print('[Lua] [exe_instances_rule] [action] no pids for exe ' .. exe .. '.')
        return
    end
    if #pids > max_instances or #pids < min_instances then
        print('[Lua] [bash_root_instances] [action] invalid number of exe ' .. exe .. ' instances found! ' .. #pids .. ' instances found!')
    else
        print("[Lua] [bash_root_instances] [action] valid number of exe " .. exe .. ' instances found. ' .. #pids .. ' instances found..')
    end
end

run()
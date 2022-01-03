package.path = package.path .. ";./lua/?.lua"

local cyberlib = require ('cyberlib') -- from {PROJECT_DIR}/lua/cyberlib.lua
-- local status_parser = require( './lua/data_sources/parsers/proc/pid/status')

print("[Lua] [exe_instances_rule] required...")
-- function pre_run()
--     print("[Lua] [exe_instances_rule] pre-running...")
--     --check {'exe pid list'}
--     return true
-- end

local default_max_instances = 12
local default_min_instances = 7

-- default_exe = '/usr/bin/bash' -- for linux
local default_exe = '/bin/dash' -- for windows with wsl

function run(exe, max_instances, min_instances, exes_pids)
    if exe == nil then
        exe = default_exe
    end
    if max_instances == nil then
        max_instances = default_max_instances
    end
    if min_instances == nil then
        min_instances = default_min_instances
    end
    if exes_pids == nil then
        exe_pids = cyberlib.rules_helpers.get_exe_pids()
    end
    cyberlib.utils.dump(exe_pids['not_ready_pids'])
    local pids = exe_pids[exe]
    if pids == nil then
        print('[Lua] [exe_instances_rule] [action] no pids for exe ' .. exe .. '.')
        return
    end
    if #pids > max_instances or #pids < min_instances then
        print('[Lua] [exe_instances_rule] [action] invalid number of exe ' .. exe .. ' instances found! ' .. #pids .. ' instances found!')
    end
end

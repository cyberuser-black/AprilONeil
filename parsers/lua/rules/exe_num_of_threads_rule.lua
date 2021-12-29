package.path = package.path .. ";./lua/?.lua"
package.path = package.path .. ";./lua/rules/?.lua"


local cyberlib = require ('cyberlib') -- from {PROJECT_DIR}/lua/cyberlib.lua

local pid_num_of_threads_rule = {}

local pid_num_of_threads_req = require 'pid_num_of_threads_rule'
pid_num_of_threads_rule.pre_run = pre_run
pid_num_of_threads_rule.run = run

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
    end
    local pids = exe_pids[exe]
    if pids == nil then
        print('[Lua] [exe_num_of_threads_rule] [action] no pids for exe ' .. exe .. '.')
        return
    end
    for i=1, #pids do
        pid_num_of_threads_rule.run(pids[i], max_threads)
    end
end
package.path = package.path .. ";./lua/?.lua"
package.path = package.path .. ";./lua/rules/?.lua"


local cyberlib = require ('cyberlib') -- from {PROJECT_DIR}/lua/cyberlib.lua

local pid_maximum_rss_memory_rule = {}

local pid_maximum_rss_memory_req = require 'pid_maximum_rss_memory_rule'
pid_maximum_rss_memory_rule.pre_run = pre_run
pid_maximum_rss_memory_rule.run = run

print("[Lua] [exe_maximum_rss_memory_rule] required...")
-- function pre_run()
--     print("[Lua] [exe_maximum_rss_memory_rule] pre-running...")
--     --check {'/proc/pid/status'}
--     return true
-- end

local default_max_rss = 100 -- in KB

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
    end
    local pids = exe_pids[exe]
    if pids == nil then
        print('[Lua] [exe_maximum_rss_memory_rule] [action] no pids for exe ' .. exe .. '.')
        return
    end
    for i=1, #pids do
        pid_maximum_rss_memory_rule.run(pids[i], max_rss)
    end
end
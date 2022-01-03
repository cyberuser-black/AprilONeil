package.path = package.path .. ";./lua/rules/?.lua"

local pid_constant_uid_gid_rule = {}
local exe_instances_rule = {}
local pid_maximum_rss_memory_rule = {}
local pid_num_of_threads_rule = {}

local pid_constant_uid_gid_req = require 'pid_constant_uid_gid_rule'
pid_constant_uid_gid_rule.pre_run = pre_run
pid_constant_uid_gid_rule.run = run

local exe_instances_req = require 'exe_instances_rule'
exe_instances_rule.pre_run = pre_run
exe_instances_rule.run = run
--
local pid_maximum_rss_memory_req = require 'pid_maximum_rss_memory_rule'
pid_maximum_rss_memory_rule.pre_run = pre_run
pid_maximum_rss_memory_rule.run = run
-- --
local pid_num_of_threads_req = require 'pid_num_of_threads_rule'
pid_num_of_threads_rule.pre_run = pre_run
pid_num_of_threads_rule.run = run

print("[Lua] [exe_instances_threads_uid_gid_rss_rule] required...")

-- function pre_run()
--     print("[Lua] [exe_instances_threads_uid_gid_rss_rule] pre-running...")
--     return system_cpu_usage.pre_run and system_ram_usage.pre_run....
-- end

-- default_exe = '/usr/bin/bash' -- for linux
local exe = '/bin/dash' -- for windows with wsl

function run()
    local exes_pids = cyberlib.rules_helpers.get_exe_pids()
    if exes_pids == nil or exes_pids[exe] == nil then
        print("[Lua] [exe_instances_threads_uid_gid_rss_rule] no pids for exe " .. exe .. "...")
        return
    end
    local exe_pids = exes_pids[exe]
    exe_instances_rule.run(nil, nil, nil, exes_pids)
    for i = 1, #exe_pids do
        pid_constant_uid_gid_rule.run(exe_pids[i])
        pid_num_of_threads_rule.run(exe_pids[i])
        pid_maximum_rss_memory_rule.run(exe_pids[i])
    end
end
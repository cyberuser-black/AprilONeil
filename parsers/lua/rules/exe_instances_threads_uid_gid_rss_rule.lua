package.path = package.path .. ";./lua/rules/?.lua"

exe_constant_uid_gid_rule = {}
exe_instances_rule = {}
exe_maximum_rss_memory_rule = {}
exe_num_of_threads_rule = {}

local system_ram_usage_req = require 'exe_constant_uid_gid_rule'
exe_constant_uid_gid_rule.pre_run = pre_run
exe_constant_uid_gid_rule.run = run
--

local exe_instances_req = require 'exe_instances_rule'
exe_instances_rule.pre_run = pre_run
exe_instances_rule.run = run
--
-- local exe_maximum_rss_memory_req = require 'exe_maximum_rss_memory_rule'
-- exe_maximum_rss_memory_rule.pre_run = pre_run
-- exe_maximum_rss_memory_rule.run = run
--
-- local exe_num_of_threads_req = require 'exe_num_of_threads_rule'
-- exe_num_of_threads_rule.pre_run = pre_run
-- exe_num_of_threads_rule.run = run


print("[Lua] [exe_instances_threads_uid_gid_rss_rule] running...")

-- function pre_run()
--     print("[Lua] [exe_instances_threads_uid_gid_rss_rule] pre-running...")
--     return system_cpu_usage.pre_run and system_ram_usage.pre_run....
-- end

function run()
    exe_constant_uid_gid_rule.run()
    exe_instances_rule.run()
--     exe_maximum_rss_memory_rule.run()
--     exe_num_of_threads_rule.run()
end

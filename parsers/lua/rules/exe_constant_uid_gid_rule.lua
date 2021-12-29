package.path = package.path .. ";./lua/?.lua"
package.path = package.path .. ";./lua/rules/?.lua"

local cyberlib = require ('cyberlib') -- from {PROJECT_DIR}/lua/cyberlib.lua

local pid_constant_uid_gid_rule = {}

local pid_constant_uid_gid_req = require 'pid_constant_uid_gid_rule'
pid_constant_uid_gid_rule.pre_run = pre_run
pid_constant_uid_gid_rule.run = run

print("[Lua] [exe_constant_uid_gid_rule] required...")
-- function pre_run()
--     print("[Lua] [exe_constant_uid_gid_rule] pre-running...")
--     --check {'/proc/pid/status'}
--     return true
-- end

local default_allowed_uids = {1000, 1000, 1000, 1000}
local default_allowed_gids = {1000, 1000, 1000, 1000}


-- default_exe = '/usr/bin/bash' -- for linux
local default_exe = '/bin/dash' -- for windows with wsl

function run(exe, allowed_uids, allowed_gids, exes_pids)
    if exe == nil then
        exe = default_exe
    end
    if allowed_uids == nil then
        allowed_uids = default_allowed_uids
    end
    if allowed_gids == nil then
        allowed_gids = default_allowed_gids
    end
    if exes_pids == nil then
        exe_pids = cyberlib.rules_helpers.get_exe_pids()
    end

    local pids = exe_pids[exe]
    if pids == nil then
        print('[Lua] [exe_constant_uid_gid_rule] [action] no pids for exe ' .. exe .. '.')
        return
    end
    for i=1, #pids do
        pid_constant_uid_gid_rule.run(pids[i], allowed_uids, allowed_gids)
    end
end
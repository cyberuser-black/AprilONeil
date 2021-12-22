package.path = package.path .. ";./lua/?.lua"

local cyberlib = require ('cyberlib') -- from {PROJECT_DIR}/lua/cyberlib.lua
-- local status_parser = require( './lua/data_sources/parsers/proc/pid/status')

print("[Lua] [exe_constant_uid_gid_rule] running...")
-- function pre_run()
--     print("[Lua] [exe_constant_uid_gid_rule] pre-running...")
--     --check {'/proc/pid/status'}
--     return true
-- end

default_allowed_uids = {1000, 1000, 1000, 1000}
default_allowed_gids = {1000, 1000, 1000, 1000}


-- default_exe = '/usr/bin/bash' -- for linux
default_exe = '/bin/dash' -- for windows with wsl

function run(exe, allowed_uids, allowed_gids)
    if exe == nil then
        exe = default_exe
    end
    if allowed_uids == nil then
        allowed_uids = default_allowed_uids
    end
    if allowed_gids == nil then
        allowed_gids = default_allowed_gids
    end

    local exe_pids = cyberlib.rules_helpers.get_exe_pids()
    local pids = exe_pids[exe]
    if pids == nil then
        print('[Lua] [exe_constant_uid_gid_rule] [action] no pids for exe ' .. exe .. '.')
        return
    end
    for i=1, #pids do
        parsed_data = cyberlib.temp.get_data('/proc/pid/status', 'open', pids[i])
        parsed_data_uid = parsed_data['Uid']
        parsed_data_gid = parsed_data['Gid']
        for j=1, #parsed_data_uid do
            if tonumber(parsed_data_uid[j]) ~= allowed_uids[j] then
                print('[Lua] [exe_constant_uid_gid_rule] [action] invalid uid[' .. j .. '], got ' .. parsed_data_uid[j] .. ', expected ' .. allowed_uids[j])
            end
            if tonumber(parsed_data_gid[j]) ~= allowed_gids[j] then
                print('[Lua] [exe_constant_uid_gid_rule] [action] invalid gid[' .. j .. '], got ' .. parsed_data_gid[j] .. ', expected ' .. allowed_gids[j])
            end
        end
    end
end

run()
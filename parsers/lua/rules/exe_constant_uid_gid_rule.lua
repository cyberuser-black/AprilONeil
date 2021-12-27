package.path = package.path .. ";./lua/?.lua"

local cyberlib = require ('cyberlib') -- from {PROJECT_DIR}/lua/cyberlib.lua
-- local status_parser = require( './lua/data_sources/parsers/proc/pid/status')

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
    else
        exe_pids = exes_pids
    end
    local pids = exe_pids[exe]
    if pids == nil then
        print('[Lua] [exe_constant_uid_gid_rule] [action] no pids for exe ' .. exe .. '.')
        return
    end
    for i=1, #pids do
        parsed_data = cyberlib.temp.get_data('/proc/' .. pids[i] .. '/status', cyberlib.temp.root_api_operations.OPEN)
        if parsed_data == nil then
            print('[Lua] [exe_constant_uid_gid_rule] [action] data is not ready for /proc/' .. pids[i] .. '/status.')
            goto continue
        end
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
        ::continue::
    end
end
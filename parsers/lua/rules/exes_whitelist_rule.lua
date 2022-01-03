package.path = package.path .. ";./lua/?.lua"

local cyberlib = require ('cyberlib') -- from {PROJECT_DIR}/lua/cyberlib.lua

print("[Lua] [exes_whitelist_rule] required...")
-- function pre_run()
--     print("[Lua] [exes_whitelist_rule] pre-running...")
--     --check {'exe pid list'}
--     return true
-- end

local default_list_of_constant_exes = {
    ['/bin/dash'] = true
}
local default_list_of_allowed_exes = {
    ['/bin/dash'] = true
}

function run(list_of_constant_exes, list_of_allowed_exes, exe_pids_arg)
    if list_of_constant_exes == nil then
        list_of_constant_exes = default_list_of_constant_exes
    end
    if list_of_allowed_exes == nil then
        list_of_allowed_exes = default_list_of_allowed_exes
    end
    local exe_pids = {}
    if exe_pids_arg == nil then
        exe_pids = cyberlib.rules_helpers.get_exe_pids()
    else
        exe_pids = exe_pids_arg
    end

    for exe, pids_list in pairs(exe_pids) do
        if list_of_allowed_exes[exe] ~= true then
            print("[Lua] [exes_whitelist_rule] [action] Untrusted 'exe' found! exe: " .. exe)
        end
        if list_of_constant_exes[exe] == true then
            list_of_constant_exes[exe] = nil
        end
    end
    if cyberlib.utils.table_len(list_of_constant_exes) > 0 then
       print("[Lua] [exes_whitelist_rule] [action] Not all constant 'exe's are running! The missing constant 'exe's are:")
       cyberlib.utils.dump(list_of_constant_exes)
    end
end

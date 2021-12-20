package.path = package.path .. ";../lua/?.lua"

lunajson = require('lunajson');
local cyberlib = require ('cyberlib') -- from {PROJECT_DIR}/lua/cyberlib.lua

print("[Lua] [mounts_test] running...")
function invoke_rule()
    print('[Lua] [mounts_test.invoke_rule] calling get_data(\'../lua/data_sources/parsers/proc/mounts.lua\')...')
    local data_current = get_data_current('../lua/data_sources/parsers/proc/mounts.lua')

    print('[Lua] [mounts_test.invoke_rule] data_current = '..data_current)

    mounts = lunajson.decode(data_current)
    local proc = mounts["proc"]

    print("[Lua] [mounts_test.invoke_rule] evaluating (" .. proc .. "...")
    if (true) then
        action(0, "[mounts_test.invoke_rule] Action invoked from rule after rootfs evaluation!")
    end
end
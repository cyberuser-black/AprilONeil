package.path = package.path .. ";../lua/?.lua"

lunajson = require('lunajson');
local cyberlib = require ('cyberlib') -- from {PROJECT_DIR}/lua/cyberlib.lua



print("[Lua] [memfree_too_low] running...")
function invoke_rule()
    print('[Lua] [memfree_too_low] calling get_data(\'../lua/data_sources/parsers/meminfo.lua\')...')
    local data_current = get_data_current('../lua/data_sources/parsers/meminfo.lua')

    print('[Lua] [memfree_too_low] data_current = '..data_current)

    meminfo = lunajson.decode(data_current)
    local memfree = tonumber(meminfo['MemFree'])

    print("[Lua] [memfree_too_low.invoke_rule] evaluating (" .. memfree .. " < 9130000) ?")
    if (memfree < 9130000) then
        action(0, "[memfree_too_low.invoke_rule] Action invoked from rule after (" .. memfree .. " < 9130000) evaluation!")
    end
end
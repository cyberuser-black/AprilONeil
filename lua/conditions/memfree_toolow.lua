print("[Lua] [memfree_toolow] running...")

lunajson = require('lunajson');

function evaluate()
    print('[Lua] [memfree_toolow] calling get_data(\'../lua/data_sources/parsers/meminfo.lua\')...')
    local data_current = get_data_current('../lua/data_sources/parsers/meminfo.lua')
    print('[Lua] [memfree_toolow] data_current = '..data_current)
    meminfo = lunajson.decode(data_current)

    local memfree = meminfo['MemFree']

    print("[Lua] [memfree_toolow.evaluate] evaluating (" .. memfree .. " < 200000) ?")
    if (tonumber(memfree) < 200000) then
        print("[Lua] [memfree_toolow.evaluate] returning TRUE!")
        return 1
    end

    print("[Lua] [memfree_toolow.evaluate] returning FALSE!")
    return 0
end
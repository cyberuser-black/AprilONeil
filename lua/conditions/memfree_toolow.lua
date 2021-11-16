lunajson = require('lunajson');

print("[Lua] [memfree_toolow] running...")
function evaluate(jsonstr_a, jsonstr_b)
    print("[Lua] [memfree_toolow.evaluate] jsonstr_a = " .. jsonstr_a)
    if jsonstr_a == 'null' or jsonstr_a == nil then
        print("[Lua] [memfree_toolow.evaluate] returning FALSE!")
        return 0
    end

    local memfree = tonumber(lunajson.decode(jsonstr_a)['MemFree'])
    print("[Lua] [memfree_toolow.evaluate] evaluating (" .. memfree .. " < 250000) ?")
    if (memfree < 250000) then
        print("[Lua] [memfree_toolow.evaluate] returning TRUE!")
        return 1
    end

    print("[Lua] [memfree_toolow.evaluate] returning FALSE!")
    return 0
end
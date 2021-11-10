lunajson = require('lunajson');

print("[Lua] example_condition.lua")
function evaluate(a, b)
    print("[Lua] [evaluate] a = " .. a)
    print("[Lua] [evaluate] b = " .. b)
    local json_a = lunajson.decode(a)
    local json_b = lunajson.decode(b)
    local str_a = lunajson.encode(json_a)
    local str_b = lunajson.encode(json_b)
    print("[Lua] [evaluate] (" .. str_a .. ") == (" .. str_b ..")")
    if (str_a == str_b) then
        print("[Lua] [evaluate] TRUE!")
        return 1
    else
        print("[Lua] [evaluate] FALSE!")
        return 0
    end
end
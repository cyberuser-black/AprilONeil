lunajson = require('lunajson');

print("[Lua] example_action.lua")
function do_action(a, b)
    local json_a = lunajson.decode(a)
    local json_b = lunajson.decode(b)
    print("[Lua] [do_action] DOING ACTION (to save the " .. json_a.hello .. ")")
end
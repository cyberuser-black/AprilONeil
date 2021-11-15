lunajson = require('lunajson');

print("[Lua] [example_action] running...")
function do_action(a, b) -- Assuming the following structure for a and b: {'result' : <something>}
    local json_a = lunajson.decode(a)
    local json_b = lunajson.decode(b)
    print("[Lua] [example_action.do_action] DOING ACTION (to save the " .. json_a.result .. ")")
end
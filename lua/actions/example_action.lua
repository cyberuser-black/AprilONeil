lunajson = require('lunajson');

print("[Lua] [example_action] running...")
function do_action(jsonstr_data)
    print("[Lua] [example_action.do_action] jsonstr_data = " .. jsonstr_data)
    local json_data = lunajson.decode(jsonstr_data)
    print("[Lua] [example_action.do_action] DOING ACTION with " .. jsonstr_data)
end
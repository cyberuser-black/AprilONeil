lunajson = require('lunajson');

print("[Lua] [example_condition] running...")
function evaluate(jsonstr_a, jsonstr_a)
    print("[Lua] [example_condition.evaluate] jsonstr_a = " .. jsonstr_a)
    print("[Lua] [example_condition.evaluate] jsonstr_b = " .. jsonstr_b)
    local json_a = lunajson.decode(jsonstr_a)
    local json_b = lunajson.decode(jsonstr_b)
    local str_a = lunajson.encode(json_a)
    local str_b = lunajson.encode(json_b)
    print("[Lua] [example_condition.evaluate] evaluating (" .. str_a .. " == " .. str_b ..") ?")
    if (str_a == str_b) then
        print("[Lua] [example_condition.evaluate] returning TRUE!")
        return 1
    else
        print("[Lua] [example_condition.evaluate] returning FALSE!")
        return 0
    end
end
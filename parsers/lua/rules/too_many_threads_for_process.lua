package.path = package.path .. ";../lua/?.lua"

lunajson = require('lunajson');
local cyberlib = require ('cyberlib') -- from {PROJECT_DIR}/lua/cyberlib.lua



print("[Lua] [too_many_threads_for_process] running...")
function invoke_rule()
    print('[Lua] [too_many_threads_for_process] calling get_data(\'../lua/data_sources/parsers/status_pid.lua\')...')
    local data_current = get_data_current('../lua/data_sources/parsers/status_pid.lua')

    print('[Lua] [too_many_threads_for_process] data_current = '..data_current)

    num_of_threads = lunajson.decode(data_current)
    local num_of_threads = tonumber(num_of_threads['Threads'])

    print("[Lua] [too_many_threads_for_process.invoke_rule] evaluating (" .. num_of_threads .. " > 0) ?")
    if (num_of_threads > 0) then
        action(0, "[too_many_threads_for_process.invoke_rule] Action invoked from rule after (" .. num_of_threads .. " > 0) evaluation!")
    end
end
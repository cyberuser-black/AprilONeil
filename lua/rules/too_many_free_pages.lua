package.path = package.path .. ";../lua/?.lua"

lunajson = require('lunajson');
local cyberlib = require ('cyberlib') -- from {PROJECT_DIR}/lua/cyberlib.lua



print("[Lua] [too_many_free_pages] running...")

function invoke_rule()
    print('[Lua] [too_many_free_pages] calling get_data(\'../lua/data_sources/parsers/vmstat.lua\')...')
    local data_current = get_data_current('../lua/data_sources/parsers/vmstat.lua')

    print('[Lua] [too_many_free_pages] data_current = '..data_current)

    nr_free_pages = lunajson.decode(data_current)
    local nr_free_pages = tonumber(nr_free_pages['nr_free_pages'])

    print("[Lua] [too_many_free_pages.invoke_rule] evaluating (" .. nr_free_pages .. " > 975000) ?")
    if (nr_free_pages > 975000) then
        action(0, "[too_many_free_pages.invoke_rule] Action invoked from rule after (" .. nr_free_pages .. " > 975000) evaluation!")
    end
end
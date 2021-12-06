package.path = package.path .. ";../lua/?.lua"

lunajson = require('lunajson');
local cyberlib = require ('cyberlib') -- from {PROJECT_DIR}/lua/cyberlib.lua



print("[Lua] [write_permissions_in_maps] running...")

function invoke_rule()
    print('[Lua] [write_permissions_in_maps] calling get_data(\'../lua/data_sources/parsers/maps_pid.lua\')...')
    local data_current = get_data_current('../lua/data_sources/parsers/maps_pid.lua')

    print('[Lua] [write_permissions_in_maps] data_current = '..data_current)

    lines = lunajson.decode(data_current)
    print("[Lua] [write_permissions_in_maps.invoke_rule] evaluating 'lines contain writing permissions'")

    for i = 1, #lines do
        if (lines[i] == nil) then goto continue end
        if (lines[i][2] == nil) then goto continue end
        if (lines[i][2]:sub(2, 2) == 'w') then
            action(0, "[write_permissions_in_maps.invoke_rule] Action invoked from rule after 'writing permissions' evaluation! Memory address with writing permissions: " .. lines[i][1])
        end
        ::continue::
    end
end
print("[Lua] [/proc/stat] running...")

-- Add {PROJECT_DIR}/lua to LUA_PATH (assuming executable runs in {PROJECT_DIR}/cmake-build-debug)
package.path = package.path .. ";./lua/?.lua"
local cyberlib = require ('cyberlib') -- from {PROJECT_DIR}/lua/cyberlib.lua

name = "stat"

function parse(data)
    print("[Lua] [/proc/stat] parse(data) "..name.."...")
    local parsed_data = cyberlib.parsers_helpers.parse_lines_to_keys_and_lists(data)
    for k, v in pairs(parsed_data) do
        io.write(k)
        for k1, v1 in pairs(v) do
            io.write(" " .. v1)
        end
        io.write('\n')
    end
    return parsed_data
end

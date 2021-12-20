print("[Lua] [/proc/<pid>/maps] running...")

-- Add {PROJECT_DIR}/lua to LUA_PATH (assuming executable runs in {PROJECT_DIR}/cmake-build-debug)
package.path = package.path .. ";./lua/?.lua"
local cyberlib = require ('cyberlib') -- from {PROJECT_DIR}/lua/cyberlib.lua

name = "maps"

function parse(pid)
    print("[Lua] [/proc/".. pid .. "/maps] parse("..name..")...")
    local parsed_data = cyberlib.parse_lines_to_lists(name, pid)
    return parsed_data
end

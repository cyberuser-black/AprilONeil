print("[Lua] [/proc/vmstat] running...")

-- Add {PROJECT_DIR}/lua to LUA_PATH (assuming executable runs in {PROJECT_DIR}/cmake-build-debug)
package.path = package.path .. ";./lua/?.lua"
local cyberlib = require ('cyberlib') -- from {PROJECT_DIR}/lua/cyberlib.lua
-- local lunajson = require ('lunajson') -- from /usr/local/share/lua/5.3/lunajson.lua

name = "vmstat"

function parse(pid)
    print("[Lua] [/proc/vmstat] parse("..name..")...")
    local parsed_data = cyberlib.parse_meminfo_style(name, pid)
--     print("[Lua] [vmstat] parsed "..parsed_data)
    return parsed_data
end

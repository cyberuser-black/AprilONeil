print("[Lua] example_parser.lua")

-- Add {PROJECT_DIR}/lua to LUA_PATH (assuming executable runs in {PROJECT_DIR}/cmake-build-debug)
package.path = package.path .. ";../lua/?.lua"
local cyberlib = require ('cyberlib') -- from {PROJECT_DIR}/lua/cyberlib.lua
local lunajson = require ('lunajson') -- from /usr/local/share/lua/5.3/lunajson.lua

cyberlib.print()

function parse()
    local json = {  ["hello"] = "world!" }
    local rawjson  = lunajson.encode(json)
    print("[Lua] [parse] " .. rawjson)
    return rawjson
end

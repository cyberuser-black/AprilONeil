print("[Lua] [example_parser] running...")

-- Add {PROJECT_DIR}/lua to LUA_PATH (assuming executable runs in {PROJECT_DIR}/cmake-build-debug)
package.path = package.path .. ";../lua/?.lua"
local cyberlib = require ('cyberlib') -- from {PROJECT_DIR}/lua/cyberlib.lua
local lunajson = require ('lunajson') -- from /usr/local/share/lua/5.3/lunajson.lua

cyberlib.print()

function parse()
    print("[Lua] [example_parser.parse] calling rootapi_readfile('dummyfile.txt')...")
    local result = rootapi_readfile("dummyfile.txt")
    print("[Lua] [example_parser.parse] result = \"" .. result .. "\"")
    local json = {  ["result"] = result }
    local jsonstr  = lunajson.encode(json)
    print("[Lua] [example_parser.parse] returning " .. jsonstr)
    return jsonstr
end

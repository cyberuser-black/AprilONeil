print("[Lua] [example_parser] running...")

-- Add {PROJECT_DIR}/lua to LUA_PATH (assuming executable runs in {PROJECT_DIR}/cmake-build-debug)
package.path = package.path .. ";../lua/?.lua"
local cyberlib = require ('cyberlib') -- from {PROJECT_DIR}/lua/cyberlib.lua
local lunajson = require ('lunajson') -- from /usr/local/share/lua/5.3/lunajson.lua

function parse()
    -- /proc/meminfo structure:
    --
    -- MemTotal:        4001688 kB
    -- MemFree:          265628 kB
    -- MemAvailable:    1078484 kB
    -- Buffers:          232908 kB
    -- Cached:           616572 kB
    -- SwapCached:         3428 kB
    -- Active:          2081856 kB
    -- ...

    -- get meminfo output
    print("[Lua] [meminfo.parse] calling rootapi_readfile('/proc/meminfo')...")
    local meminfo = rootapi_readfile("/proc/meminfo")

    -- convert meminfo output to json
    local json = cyberlib.meminfo_to_json(meminfo)

    local jsonstr  = lunajson.encode(json)
    print("[Lua] [meminfo.parse] returning " .. jsonstr)
    return jsonstr
end

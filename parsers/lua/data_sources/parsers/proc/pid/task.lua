-- /proc/[tid] subdirectories
--     Each one of these subdirectories contains files and
--     subdirectories exposing information about the thread with
--     the corresponding thread ID.  The contents of these
--     directories are the same as the corresponding
--     /proc/[pid]/task/[tid] directories.
--
--     The /proc/[tid] subdirectories are not visible when
--     iterating through /proc with getdents(2) (and thus are not
--     visible when one uses ls(1) to view the contents of
--     /proc).

 print("[Lua] [/proc/<pid>/task] running...")

-- Add {PROJECT_DIR}/lua to LUA_PATH (assuming executable runs in {PROJECT_DIR}/cmake-build-debug)
package.path = package.path .. ";./lua/?.lua"
local cyberlib = require ('cyberlib') -- from {PROJECT_DIR}/lua/cyberlib.lua


name = "task"

function parse(pid)
    parsed_data = {}
    print("[Lua] [/proc/" .. pid .. "/task] parse("..name..")...")
    dir_list = rootapi_list_dir("/proc/" .. pid .. "/task")
--     for k, v in pairs(dir_list) do
--         print(k, v)
--         parsed_data[v] = cyberlib.parse_meminfo_style(name .. "/task", pid)
--     end
--     return parsed_data

-- TODO: check whether to parse each thread in pid/task to smaller parts.parsed_data
    return dir_list
end

package.path = package.path .. ";./lua/?.lua"

local cyberlib = require ('cyberlib') -- from {PROJECT_DIR}/lua/cyberlib.lua
-- local status_parser = require( './lua/data_sources/parsers/proc/pid/status')

print("[Lua] [system_ram_usage] required...")
-- function pre_run()
--     print("[Lua] [system_ram_usage] pre-running...")
--     --check {'/proc/meminfo'}
--     return true
-- end

local default_max_ram_diff = 0.0001 -- in percentages

local default_temp_file_name = 'temp_meminfo_ram_diff_data'

function run(max_ram_diff, temp_file_name)
    if max_ram_diff == nil then
        max_ram_diff = default_max_ram_diff
    end
    if temp_file_name == nil then
        temp_file_name = default_temp_file_name
    end
    print('[Lua] [system_ram_usage] getting new ram data...')
    local ram_parsed_data = cyberlib.temp.get_data('/proc/meminfo', cyberlib.temp.root_api_operations.OPEN)
    if ram_parsed_data == nil then
        print('[Lua] [system_ram_usage] [action] data is not ready for /proc/meminfo.')
        return
    end
    local memTotal = tonumber(ram_parsed_data['MemTotal'])
    local memFree = tonumber(ram_parsed_data['MemFree'])
    local diff = 100 * (memTotal - memFree) / memTotal


    print('[Lua] [system_ram_usage] loading and replacing old data')
    local old_diff = cyberlib.temp.replace_data(temp_file_name, diff)
    if old_diff == nil then
        print("[Lua] [system_ram_usage] [action] old_data not found, can't compare to old value...")
        return
    end
    local abs_diff = math.abs(diff - old_diff)
    if abs_diff > max_ram_diff then
        print('[Lua] [system_ram_usage] [action] more than ' .. max_ram_diff .. ' diff in ram!, ' .. abs_diff .. ' diff found!')
    else
        print("[Lua] [system_ram_usage] [action] less than " .. max_ram_diff .. ' diff in ram!, ' .. abs_diff .. ' diff found..')
    end
end
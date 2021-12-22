package.path = package.path .. ";./lua/?.lua"

local cyberlib = require ('cyberlib') -- from {PROJECT_DIR}/lua/cyberlib.lua
-- local status_parser = require( './lua/data_sources/parsers/proc/pid/status')

print("[Lua] [system_ram_usage] running...")
-- function pre_run()
--     print("[Lua] [system_ram_usage] pre-running...")
--     --check {'/proc/meminfo'}
--     return true
-- end

default_max_ram_diff = 0.0001 -- in percentages

default_temp_file_name = 'temp_meminfo_ram_diff_data'

function run(max_ram_diff, temp_file_name)
    if max_ram_diff == nil then
        max_ram_diff = default_max_ram_diff
    end
    if temp_file_name == nil then
        temp_file_name = default_temp_file_name
    end
    print('[Lua] [system_ram_usage] getting new ram data...')
    local ram_parsed_data = cyberlib.temp.get_data('/proc/meminfo', 'open')
    local memTotal = tonumber(ram_parsed_data['MemTotal'])
    local memFree = tonumber(ram_parsed_data['MemFree'])
    local diff = (memTotal - memFree) / memTotal
    local table_to_save = {}
    table_to_save.diff = tostring(diff)

    print('[Lua] [system_ram_usage] loading old data')
    local old_data = cyberlib.temp.read_global_variable_from_file(temp_file_name)
    if old_data == nil then
        print("[Lua] [system_ram_usage] [action] old_data not found, can't compare to old value...")
        cyberlib.temp.set_data(temp_file_name, table_to_save)
        return
    end
    cyberlib.temp.set_data(temp_file_name, table_to_save)
    local old_diff = tonumber(old_data['diff'])

    if math.abs(diff - old_diff) > max_ram_diff then
        print('[Lua] [system_ram_usage] [action] more than ' .. max_ram_diff .. ' diff in ram!, ' .. (diff - old_diff) .. ' diff found!')
    else
        print("[Lua] [system_ram_usage] [action] less than " .. max_ram_diff .. ' diff in ram!, ' .. (diff - old_diff) .. ' diff found..')
    end
end

run()
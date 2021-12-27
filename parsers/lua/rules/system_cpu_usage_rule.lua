package.path = package.path .. ";./lua/?.lua"

local cyberlib = require ('cyberlib') -- from {PROJECT_DIR}/lua/cyberlib.lua
-- local status_parser = require( './lua/data_sources/parsers/proc/pid/status')

print("[Lua] [system_cpu_usage] required...")
-- function pre_run()
--     print("[Lua] [system_cpu_and_ram_usage] pre-running...")
--     --check {'/proc/stat'}
--     return true
-- end

local default_max_cpu_diff = 0.0001 -- in percentages

local default_temp_file_name = 'temp_proc_stat_cpu_diff_data'

function run(max_cpu_diff, temp_file_name)
    if max_cpu_diff == nil then
        max_cpu_diff = default_max_cpu_diff
    end
    if temp_file_name == nil then
        temp_file_name = default_temp_file_name
    end
    print('[Lua] [system_cpu_usage] getting new cpu data...')
    local cpu_parsed_data = cyberlib.temp.get_data('/proc/stat', cyberlib.temp.root_api_operations.OPEN)
    if cpu_parsed_data == nil then
        print('[Lua] [system_cpu_and_ram_usage] [action] data is not ready for /proc/stat.')
        return
    end
    local new_cpu_data = cpu_parsed_data['cpu']
    local diff = 100 * (new_cpu_data[1] + new_cpu_data[3]) / (new_cpu_data[1] + new_cpu_data[3] + new_cpu_data[4])

    print('[Lua] [system_cpu_usage] loading and replacing old data')
    local old_diff = cyberlib.temp.replace_data(temp_file_name, diff)
    if old_diff == nil then
        print("[Lua] [system_cpu_usage] [action] old_data not found, can't compare to old value...")
        return
    end
    local abs_diff = math.abs(diff - old_diff)
    if abs_diff > max_cpu_diff then
        print('[Lua] [system_cpu_usage] [action] more than ' .. max_cpu_diff .. ' diff in cpu!, ' .. abs_diff .. ' diff found!')
    else
        print("[Lua] [system_cpu_usage] [action] less than " .. max_cpu_diff .. ' diff in cpu, ' .. abs_diff .. ' diff found..')
    end
end
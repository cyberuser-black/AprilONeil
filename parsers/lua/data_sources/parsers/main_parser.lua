package.path = package.path .. ";./lua/?.lua"
local cyberlib = require('cyberlib')
print("Main parser running...")

function main_parse(data_path, data)
    if data == nil then
        return nil
    end
    local parser_path = cyberlib.main_parser_helpers.format_data_path_to_parser_path(data_path)
    require('./lua/data_sources/parsers' .. parser_path)
    print('[Lua] [main_parser] Parsing parser ' .. parser_path .. ' from file ' .. data_path)
    return parse(data)
end


package.path = package.path .. ";./lua/?.lua"
local cyberlib = require('cyberlib')
print("Main parser running...")

local params = {...}
print("Running ", params[1])
path_split = cyberlib.utils.split(params[1], '/')
if path_split[2] == "pid" then
   pid = params[2]
else
   pid = ''
end

local parser_script = require ('./lua/data_sources/parsers' .. params[1] )
local parsed_data = cyberlib.temp.get_data(params[1], params[2], params[3])
for k, v in pairs(parsed_data) do
   print(k, v)
end
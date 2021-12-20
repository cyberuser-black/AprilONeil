package.path = package.path .. ";./lua/?.lua"
local cyberlib = require('cyberlib')
print("Main parser running...")
-- gedit_pids = cyberlib.get_exe_pids('gedit')
-- table_to_str(gedit_pids)
local params = {...}
print("Running ", params[1])
path_split = cyberlib.split(params[1], '/')
if path_split[2] == "pid" then
   pid = params[2]
else
   pid = ''
end

local parser_script = require ('./lua/data_sources/parsers' .. params[1] )
local parsed_data = parse(pid)
for k, v in pairs(parsed_data) do
   print(k, v)
end
package.path = package.path .. ";./lua/?.lua"
local cyberlib = require('cyberlib')
print("Python parser running...")

local params = {...}
print("Running ", params[1])

local parsed_data = cyberlib.temp.get_data(params[1], tonumber(params[2]))
cyberlib.utils.dump(parsed_data)

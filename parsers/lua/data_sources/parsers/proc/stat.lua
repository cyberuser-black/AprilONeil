print("[Lua] [/proc/stat] running...")
-- output example:
--
-- 	cpu2={
-- 		861515,
-- 		0,
-- 		7361440,
-- 		56158864,
-- 		0,
-- 		8685,
-- 		0,
-- 		0,
-- 		0,
-- 		0
-- 	},
-- 	softirq={
-- 		531871,
-- 		0,
-- 		166655,
-- 		5588,
-- 		285920,
-- 		8660,
-- 		0,
-- 		272,
-- 		0,
-- 		791,
-- 		63985
-- 	},
-- 	processes={
-- 		8389
-- 	},
-- 	cpu6={
-- 		596323,
-- 		0,
-- 		5515704,
-- 		58269792,
-- 		0,
-- 		6270,
-- 		0,
-- 		0,
-- 		0,
-- 		0
-- 	},
-- 	procs_blocked={
-- 		0
-- 	},
-- 	cpu1={
-- 		332715,
-- 		0,
-- 		4421723,
-- 		59627381,
-- 		0,
-- 		41393,
-- 		0,
-- 		0,
-- 		0,
-- 		0
-- 	},
-- 	cpu5={
-- 		509062,
-- 		0,
-- 		4770485,
-- 		59102271,
-- 		0,
-- 		4068,
-- 		0,
-- 		0,
-- 		0,
-- 		0
-- 	},
-- 	intr={
-- 		894498,
-- 		377553,
-- 		332,
-- 		0,
-- 		0,
-- 		0,
-- 		0,
-- 		0,
-- 		0,
-- 		0,
-- 		287178,
-- 		0,
-- 		0,
-- 		1078,
-- 		0,
-- 		8572,
-- 		189,
-- 		0,
-- 		0,
-- 		0,
-- 		0,
-- 		0,
-- 		0,
-- 		0,
-- 		0,
-- 		0,
-- 		0,
-- 		0,
-- 		0,
-- 		0,
-- 		0,
-- 		0,
-- 		0,
-- 		0,
-- 		0,
-- 		.
-- 		.
-- 		.
-- 		.
-- 		.
-- 		0,
-- 		0
-- 	},
-- 	cpu7={
-- 		266231,
-- 		0,
-- 		7235517,
-- 		56880071,
-- 		0,
-- 		1404,
-- 		0,
-- 		0,
-- 		0,
-- 		0
-- 	},
-- 	btime={
-- 		1639994632
-- 	},
-- 	ctxt={
-- 		494453
-- 	},
-- 	cpu3={
-- 		279000,
-- 		0,
-- 		10357235,
-- 		53745584,
-- 		0,
-- 		3407,
-- 		0,
-- 		0,
-- 		0,
-- 		0
-- 	},
-- 	cpu={
-- 		4182887,
-- 		0,
-- 		48377396,
-- 		462494267,
-- 		0,
-- 		412615,
-- 		0,
-- 		0,
-- 		0,
-- 		0
-- 	},
-- 	cpu4={
-- 		705693,
-- 		0,
-- 		4025885,
-- 		59650240,
-- 		0,
-- 		11195,
-- 		0,
-- 		0,
-- 		0,
-- 		0
-- 	},
-- 	cpu0={
-- 		632348,
-- 		0,
-- 		4689407,
-- 		59060064,
-- 		0,
-- 		336193,
-- 		0,
-- 		0,
-- 		0,
-- 		0
-- 	},
-- 	procs_running={
-- 		1
-- 	}



-- Add {PROJECT_DIR}/lua to LUA_PATH (assuming executable runs in {PROJECT_DIR}/cmake-build-debug)
package.path = package.path .. ";./lua/?.lua"
local cyberlib = require ('cyberlib') -- from {PROJECT_DIR}/lua/cyberlib.lua

name = "stat"

function parse(data)
    print("[Lua] [/proc/stat] parse(data) "..name.."...")
    local parsed_data = cyberlib.parsers_helpers.parse_lines_to_keys_and_lists(data)
    for key, list in pairs(parsed_data) do
        for i = 1, #list do
            list[i] = tonumber(list[i])
        end
        parsed_data[key] = list
    end
    return parsed_data
end
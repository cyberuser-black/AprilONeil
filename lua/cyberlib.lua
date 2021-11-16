print("[Lua] [cyberlib] running...")
local cyberlib = {}

function cyberlib.print()
    print("[Lua] [cyberlib.print] Cyber!")
    end

function cyberlib.add(a, b)
    return (a + b)
    end

function cyberlib.split(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={}
	i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str i = i + 1
	end
	return t
end

function cyberlib.meminfo_to_json(meminfo_dump)
    local json = {}
    for line in meminfo_dump:gmatch("[^\r\n]*") do
        -- line = 'MemTotal:        4001688 kB'
        line = line:gsub(':', '') -- remove the ':' char
        local parsed_line = cyberlib.split(line)

        -- key = 'MemTotal', memory = '4001688', size = 'kB'
        local key = parsed_line[1]
        local memory = parsed_line[2]
        local size = parsed_line[3]
        if key == nil then goto continue end
        if memory == nil then memory = "" else memory = memory:gsub('%s+', '') end
        if size == nil then size = "" end
        json[key] = memory -- .. " " .. size

        ::continue::
    end
    return json
end

return cyberlib
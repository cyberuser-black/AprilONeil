print("[Lua] [cyberlib] running...")
local lunajson = require ('lunajson') -- from /usr/local/share/lua/5.3/lunajson.lua
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

function cyberlib.get_proc_path(parser_name, pid)
    if pid == 'null' or pid == nil then
        pid = ''
    else
        pid = pid .. '/'
    end
    return "/proc/" ..pid..parser_name
end

function cyberlib.keyval_lines_to_json(keyval_lines)
    --[[
    INPUT FORMAT (Key-Value Lines):
       MemTotal:        4001688 kB
       MemFree:          265628 kB
       MemAvailable:    1078484 kB
       ...
    OUTPUT FORMAT (JSON):
       { "MemTotal" : "4001688", "MemFree" : "265628", "MemAvailable" : "1078484", ...}
    ]]

    local json = {}
    for line in keyval_lines:gmatch("[^\r\n]*") do
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

function cyberlib.multiple_values_lines_to_json(lines)
    --[[
    INPUT FORMAT (Multiple Values Lines):
        55b980783000-55b980784000 rw-p 0000a000 103:01 6144152                   /usr/bin/cat
        55b9825a5000-55b9825c6000 rw-p 00000000 00:00 0                          [heap]
        7fdf30962000-7fdf30984000 rw-p 00000000 00:00 0
        ...
    OUTPUT FORMAT (JSON):
       { "MemTotal" : "4001688", "MemFree" : "265628", "MemAvailable" : "1078484", ...}
    ]]

    local json = {}
    local i = 1
    for line in lines:gmatch("[^\r\n]*") do
        -- line = '55b980783000-55b980784000 rw-p 0000a000 103:01 6144152                   /usr/bin/cat'
        local parsed_line = cyberlib.split(line)

        if parsed_line == nil then goto continue end
        json[i] = parsed_line
        i = i + 1
        ::continue::
    end
    return json
end

function cyberlib.parse_meminfo_style(parser_name, pid)
    local parser_path = cyberlib.get_proc_path(parser_name, pid)
    local parser_dump = rootapi_readfile(parser_path)
    local json = cyberlib.keyval_lines_to_json(parser_dump)
    jsonstr = lunajson.encode(json)
    return jsonstr
end

function cyberlib.parse_lines_to_lists(parser_name, pid)
    local parser_path = cyberlib.get_proc_path(parser_name, pid)
    local parser_dump = rootapi_readfile(parser_path)
    local json = cyberlib.multiple_values_lines_to_json(parser_dump)
    jsonstr = lunajson.encode(json)
    return jsonstr
end

return cyberlib

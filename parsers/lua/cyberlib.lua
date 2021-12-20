print("[Lua] [cyberlib] running...")
-- local lunajson = require ('lunajson') -- from /usr/local/share/lua/5.3/lunajson.lua
local cyberlib = {}
local pp = require('../pp/pp')

function rootapi_readfile(path)
    local file = io.open(path, "rb") -- r read mode and b binary mode
    if not file then
        return nil
    end
    local content = file:read "*a" -- *a or *all reads the whole file
    file:close()
    return content
end

function rootapi_list_dir(path)
    local i, t, popen = 0, {}, io.popen
    local pfile = popen('ls -a "'..path..'"')
    for filename in pfile:lines() do
        if(filename ~= '..' and filename ~= '.') then
            i = i + 1
            t[i] = filename
        end
    end
    pfile:close()
    return t
end

function rootapi_list_dir_detailed(path)
    local i, t, popen = 0, {}, io.popen
    local pfile = popen('ls -la "'..path..'" 2>/dev/null')
    for filename in pfile:lines() do
        if(filename ~= '..' and filename ~= '.') then
            i = i + 1
            t[i] = filename
        end
    end
    pfile:close()
    return t
end

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
    local t = {}
    i = 1
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

function cyberlib.get_proc_path(parser_name, pid)
    if pid == 'null' or pid == nil then
        pid = ''
    else
        pid = pid .. '/'
    end
    return "/proc/" .. pid .. parser_name
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
        if key == nil then
            goto continue
        end
        if memory == nil then
            memory = ""
        else
            memory = memory:gsub('%s+', '')
        end
        if size == nil then
            size = ""
        end
        json[key] = memory -- .. " " .. size

        :: continue ::
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
       { 1: '55b980783000-55b980784000, 2: rw-p, 3: 0000a00, 4: 103:01, 5: 6144152, 6: /usr/bin/cat'}
    ]]

    local json = {}
    local i = 1
    for line in lines:gmatch("[^\r\n]*") do
        local parsed_line = cyberlib.split(line)

        if parsed_line == nil then
            goto continue
        end
        json[i] = parsed_line
        i = i + 1
        :: continue ::
    end
    return json

end

function cyberlib.multiple_values_lines_to_keys_and_lists(lines)
    --[[
    INPUT FORMAT (Multiple Values Lines):
        Name:	bash
        Umask:	0002
        State:	S (sleeping)
        Tgid:	211055
        Ngid:	0
        Pid:	211055
        PPid:	211048
        TracerPid:	0
        Uid:	1000	1000	1000	1000
        ...
    OUTPUT FORMAT (JSON):
       { Name: {1: bash}, Umask..., Uid: {1: 1000, 2: 1000, 3: 1000, : 1000}, ...}
    ]]

    local json = {}
    for line in lines:gmatch("[^\r\n]*") do
        -- line = '55b980783000-55b980784000 rw-p 0000a000 103:01 6144152                   /usr/bin/cat'

        local parsed_line = cyberlib.split(line)
        if parsed_line == nil then
            goto continue
        end
        local new_key = parsed_line[1]
        if new_key == nil then
            goto continue
        end
        new_key = new_key:gsub(':', '') -- remove the ':' char
        new_parsed_line = {}
        for i = 2, #parsed_line do
            new_parsed_line[i -1] = parsed_line[i]
        end
        json[new_key] = new_parsed_line
        :: continue ::
    end
    return json
end

function cyberlib.parse_meminfo_style(parser_name, pid)
    local parser_path = cyberlib.get_proc_path(parser_name, pid)
    local parser_dump = rootapi_readfile(parser_path)
    local json = cyberlib.keyval_lines_to_json(parser_dump)
    return json
end

function cyberlib.parse_lines_to_keys_and_lists(parser_name, pid)
    local parser_path = cyberlib.get_proc_path(parser_name, pid)
    local parser_dump = rootapi_readfile(parser_path)
    local json = cyberlib.multiple_values_lines_to_keys_and_lists(parser_dump)
    return json
end

function cyberlib.parse_lines_to_lists(parser_name, pid)
    local parser_path = cyberlib.get_proc_path(parser_name, pid)
    local parser_dump = rootapi_readfile(parser_path)
    local json = cyberlib.multiple_values_lines_to_json(parser_dump)
    return json
end

function cyberlib.parse_list_dir_to_links(parser_name, pid)
    local parser_path = cyberlib.get_proc_path(parser_name, pid)
    local list_dir = rootapi_list_dir_detailed(parser_path)
    local parsed_links = {}
    for k, v in pairs(list_dir) do
        split_v = cyberlib.split(v, '>')
        split_new_k = cyberlib.split(split_v[1], ' ')
--         print(split_v[1])
--         print(v)
        if split_new_k[9] ~= nil then
            parsed_links[split_new_k[9]] = split_v[2]
        end
    end
    return parsed_links
end

function cyberlib.root_api_readlink(parser_name, pid)
    local path = cyberlib.get_proc_path(parser_name, pid)
    local popen = io.popen
    local pfile = popen('readlink "'..path..'" 2>/dev/null')
    return pfile:read()
end

-- Lua implementation of PHP scandir function
function scandir(directory)
    --print('scandir...')
    local i, t, popen = 0, {}, io.popen
    --print('ls -a "'..directory..'"')
    local pfile = popen('ls -a "' .. directory .. '"')
    --print(pfile:lines())
    for filename in pfile:lines() do
        --print(filename)
        i = i + 1
        t[i] = filename
    end
    pfile:close()
    return t
end

function cyberlib.get_exe_pids()
    print('get_exe_pids...')
    local exe_pids = {}
    local proc = scandir('/proc')
    for i, filename in pairs(proc) do
        pid = tonumber(filename)
        if (pid ~= nil) then
            local ls_exe = cyberlib.root_api_readlink('exe', pid)
            if ls_exe ~= nil then
                local ls_exe_split = cyberlib.split(ls_exe, " ");
                local exe = ls_exe_split[#ls_exe_split]
                if exe_pids[exe] == nil then
                    exe_pids[exe] = { pid }
                else
                    table.insert(exe_pids[exe], pid)
                end
            end
        end
    end
--     dump(exe_pids)
    return exe_pids
end

function table_to_str(o)
    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then
                k = '"' .. k .. '"'
            end
            s = s .. '[' .. k .. '] = ' .. table_to_str(v) .. ','
        end
        return s .. '}'
    else
        return tostring(o)
    end
end

function dump(o)
    pp.print(o, '\t')
end

return cyberlib

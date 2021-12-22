print("[Lua] [cyberlib] running...")
package.path = package.path .. ";./lua/?.lua"
package.path = package.path .. ";./lua/data_sources/?.lua"
package.path = package.path .. ";./lua/data_sources/parsers/?.lua"
package.path = package.path .. ";./lua/data_sources/parsers/proc/?.lua"
package.path = package.path .. ";./lua/data_sources/parsers/proc/pid/?.lua"

local pp = require('../pp/pp')
local parsers_helpers = {}
local root_api = {}
local temp = {}
local utils = {}
local rules_helpers = {}

cyberlib = {}
cyberlib.parsers_helpers = parsers_helpers
cyberlib.rules_helpers = rules_helpers
cyberlib.utils = utils
cyberlib.temp = temp
-------------------------------------------------------------------------------

-- root api class

function root_api.readlink(parser_name, pid)
    -- mimics a root_api protocol to readlink.
    local path = utils.get_proc_path(parser_name, pid)
    local popen = io.popen
    local pfile = popen('readlink "'..path..'" 2>/dev/null')
    return pfile:read()
end

function root_api.readfile(path)
    -- mimics a root_api protocol to read (open) a file.
    local file = io.open(path, "rb") -- r read mode and b binary mode
    if not file then
        return nil
    end
    local content = file:read "*a" -- *a or *all reads the whole file
    file:close()
    return content
end

function root_api.list_dir(path)
    -- mimics a root_api protocol to list a dir
    local i, t, popen = 0, {}, io.popen
    local pfile = popen('ls -la "'..path..'"')
    for filename in pfile:lines() do
        if(filename ~= '..' and filename ~= '.') then
            i = i + 1
            t[i] = filename
        end
    end
    pfile:close()
    return t
end

----------------------------------------------------------------------------

-- temp class

-- parser_path = '/proc/pid/parser' or '/proc/parser'
function temp.get_data(parser_path, root_api_operation, pid)
    -- use this function in rules to call get_data. later will be replaced by
    -- the real function.
    if pid == nil then
        pid = ''
    end
    require_value = require(parser_path)
    if (root_api_operation == 'open') then
        return parse(root_api.readfile(parser_path:gsub('pid', pid)))
    elseif (root_api_operation == 'list_dir') then
        return parse(root_api.list_dir(parser_path:gsub('pid', pid)))
    elseif (root_api_operation == 'read_link') then
        return parse(root_api.readlink(parser_path:gsub('pid', pid)))
    end
    return nil
end

function temp.set_data(filename, tbl)
   local function exportstring( s )
    return string.format("%q", s)
   end
    local charS,charE = "   ","\n"
    local file,err = io.open( filename, "wb" )
    if err then return err end

    -- initiate variables for save procedure
    local tables,lookup = { tbl },{ [tbl] = 1 }
    file:write( "return {"..charE )

    for idx,t in ipairs( tables ) do
     file:write( "-- Table: {"..idx.."}"..charE )
     file:write( "{"..charE )
     local thandled = {}

     for i,v in ipairs( t ) do
        thandled[i] = true
        local stype = type( v )
        -- only handle value
        if stype == "table" then
           if not lookup[v] then
              table.insert( tables, v )
              lookup[v] = #tables
           end
           file:write( charS.."{"..lookup[v].."},"..charE )
        elseif stype == "string" then
           file:write(  charS..exportstring( v )..","..charE )
        elseif stype == "number" then
           file:write(  charS..tostring( v )..","..charE )
        end
     end

     for i,v in pairs( t ) do
        -- escape handled values
        if (not thandled[i]) then

           local str = ""
           local stype = type( i )
           -- handle index
           if stype == "table" then
              if not lookup[i] then
                 table.insert( tables,i )
                 lookup[i] = #tables
              end
              str = charS.."[{"..lookup[i].."}]="
           elseif stype == "string" then
              str = charS.."["..exportstring( i ).."]="
           elseif stype == "number" then
              str = charS.."["..tostring( i ).."]="
           end

           if str ~= "" then
              stype = type( v )
              -- handle value
              if stype == "table" then
                 if not lookup[v] then
                    table.insert( tables,v )
                    lookup[v] = #tables
                 end
                 file:write( str.."{"..lookup[v].."},"..charE )
              elseif stype == "string" then
                 file:write( str..exportstring( v )..","..charE )
              elseif stype == "number" then
                 file:write( str..tostring( v )..","..charE )
              end
           end
        end
     end
     file:write( "},"..charE )
    end
    file:write( "}" )
    file:close()
end

function temp.read_global_variable_from_file(sfile)
    local ftables,err = loadfile( sfile )
    if err then return _,err end
    local tables = ftables()
    for idx = 1,#tables do
     local tolinki = {}
     for i,v in pairs( tables[idx] ) do
        if type( v ) == "table" then
           tables[idx][i] = tables[v[1]]
        end
        if type( i ) == "table" and tables[i[1]] then
           table.insert( tolinki,{ i,tables[i[1]] } )
        end
     end
     -- link indices
     for _,v in ipairs( tolinki ) do
        tables[idx][v[2]],tables[idx][v[1]] =  tables[idx][v[1]],nil
     end
    end
    return tables[1]
end

----------------------------------------------------------------------------

-- utils class

function utils.get_proc_path(parser_name, pid)
    -- gets the proc_path of the given parser name and pid (if given)
    if pid == 'null' or pid == nil then
        pid = ''
    else
        pid = pid .. '/'
    end
    return "/proc/" .. pid .. parser_name
end

function utils.print()
    print("[Lua] [cyberlib.print] Cyber!")
end

function utils.split(inputstr, sep)
    -- splits the inputstr by the sep.
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

function utils.table_to_str(o)
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

function utils.dump(o)
    pp.print(o, '\t')
end

-- Lua implementation of PHP scandir function
function utils.scandir(directory)
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

------------------------------------------------------------------------------

-- parsers helpers class

function parsers_helpers.parse_key_val_style(data)
        --[[
    INPUT FORMAT (Key-Value Lines):
       MemTotal:        4001688 kB
       MemFree:          265628 kB
       MemAvailable:    1078484 kB
       ...
    OUTPUT FORMAT:
       { "MemTotal" : "4001688", "MemFree" : "265628", "MemAvailable" : "1078484", ...}
    ]]

    local parsed_data = {}
    for line in data:gmatch("[^\r\n]*") do
        -- line = 'MemTotal:        4001688 kB'
        line = line:gsub(':', '') -- remove the ':' char
        local parsed_line = utils.split(line)

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
        parsed_data[key] = memory -- .. " " .. size

        :: continue ::
    end
    return parsed_data
end

function parsers_helpers.parse_lines_to_keys_and_lists(data)
    -- input - data
    -- output - parses each line to key and the rest of the line as a value of the key as list.
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
    OUTPUT FORMAT:
       { Name: {1: bash}, Umask..., Uid: {1: 1000, 2: 1000, 3: 1000, : 1000}, ...}
    ]]

    local parsed_data = {}
    for line in data:gmatch("[^\r\n]*") do
        local parsed_line = utils.split(line)
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
        parsed_data[new_key] = new_parsed_line
        :: continue ::
    end
    return parsed_data
end

function parsers_helpers.parse_lines_to_lists_of_lists(data)
    -- input - data
    -- output - each line as a list (seperated by white spaces)
        --[[
    INPUT FORMAT (Multiple Values Lines):
        55b980783000-55b980784000 rw-p 0000a000 103:01 6144152                   /usr/bin/cat
        55b9825a5000-55b9825c6000 rw-p 00000000 00:00 0                          [heap]
        7fdf30962000-7fdf30984000 rw-p 00000000 00:00 0
        ...
    OUTPUT FORMAT (each line parsed to):
       { 1: '55b980783000-55b980784000, 2: rw-p, 3: 0000a00, 4: 103:01, 5: 6144152, 6: /usr/bin/cat'}
    ]]

    local parsed_data = {}
    local i = 1
    for line in data:gmatch("[^\r\n]*") do
        local parsed_line = utils.split(line)

        if parsed_line == nil then
            goto continue
        end
        parsed_data[i] = parsed_line
        i = i + 1
        :: continue ::
    end
    return parsed_data
end

function parsers_helpers.parse_list_dir_to_links(data)
    -- input - data of 'ls -la'
    -- output - parses an output data of the command 'ls -la' to keys and
    -- values of the links in this list
    local list_dir = data
    local parsed_links = {}
    for k, v in pairs(list_dir) do
        split_v = utils.split(v, '>')
        split_new_k = utils.split(split_v[1], ' ')
        if split_new_k[9] ~= nil then
            parsed_links[split_new_k[9]] = split_v[2]
        end
    end
    return parsed_links
end

function parsers_helpers.parse_list_dir_to_regular_list(data)
    -- input - data of 'ls -la'
    -- output - parses an output data of the command 'ls -la' to keys only (drop links)
    local parsed_links = {}
    for k, v in pairs(list_dir) do
        split_v = utils.split(v, '>')
        split_new_k = utils.split(split_v[1], ' ')
        if (split_new_k[9] ~= nil and split_new_k[9] ~= '.' and split_new_k[9] ~= '..') then
            parsed_links[k] = split_new_k[9]
        end
    end
    return parsed_links
end

----------------------------------------------------------------------------

-- rules helpers class

function rules_helpers.get_exe_pids()
    -- returns a table of exe's, and for each exe a list of it's pid's.
    print('get_exe_pids...')
    local exe_pids = {}
    local proc = utils.scandir('/proc')
    for i, filename in pairs(proc) do
        pid = tonumber(filename)
        if (pid ~= nil) then
            local ls_exe = root_api.readlink('exe', pid)
            if ls_exe ~= nil then
                local ls_exe_split = utils.split(ls_exe, " ");
                local exe = ls_exe_split[#ls_exe_split]
                if exe_pids[exe] == nil then
                    exe_pids[exe] = { pid }
                else
                    table.insert(exe_pids[exe], pid)
                end
            end
        end
    end
    return exe_pids
end

return cyberlib

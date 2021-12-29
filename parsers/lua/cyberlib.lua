print("[Lua] [cyberlib] required...")
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
local main_parser_helpers = {}
local lambdas = {}

cyberlib = {}
cyberlib.parsers_helpers = parsers_helpers
cyberlib.rules_helpers = rules_helpers
cyberlib.utils = utils
cyberlib.temp = temp
cyberlib.main_parser_helpers = main_parser_helpers
cyberlib.lambdas = lambdas
-------------------------------------------------------------------------------

-- root api class

function root_api.readlink(path)
    -- mimics a root_api protocol to readlink.
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

function root_api.list_links_dir(path)
    -- mimics a root_api protocol to list links in a dir
    local i, t, links_t, link, popen = 0, {}, {}, '', io.popen
    local pfile = popen('ls -a "'..path..'"')
    for filename in pfile:lines() do
        if(filename ~= '..' and filename ~= '.') then
            i = i + 1
            t[i] = filename
        end
    end
    pfile:close()
    i = 1
    for k, v in pairs(t) do
        link = root_api.readlink(path .. v)
        if link ~= nil then
            links_t[i] = link
            i = i + 1
        end
    end
    return links_t
end

function root_api.list_dir(path)
    -- mimics a root_api protocol to list a dir
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

----------------------------------------------------------------------------

-- temp class

temp.root_api_operations = {
    OPEN = 1,
    LIST_DIR = 2,
    READ_LINK = 3,
    LIST_LINKS_DIR = 4
}
local main_parser_path = 'main_parser'
-- parser_path = '/proc/<pid>/parser' or '/proc/parser' (<pid> is a real pid)
function temp.get_data(data_path, root_api_operation)
    -- use this function in rules to call get_data. later will be replaced by
    -- the real function.
    require_value = require(main_parser_path)
    if (root_api_operation == temp.root_api_operations.OPEN) then
        return main_parse(data_path, root_api.readfile(data_path))
    elseif (root_api_operation == temp.root_api_operations.LIST_DIR) then
        return root_api.list_dir(data_path)
    elseif (root_api_operation == temp.root_api_operations.READ_LINK) then
        return root_api.readlink(data_path)
    elseif (root_api_operation == temp.root_api_operations.LIST_LINKS_DIR) then
        return root_api.list_links_dir(data_path)
    else
        return nil -- return nill if the data is not ready or the requested operation is illegal.
    end
end

function temp.set_data(filename, value_to_save)
   local function exportstring( s )
    return string.format("%q", s)
   end
    tbl = {}
    tbl.value = value_to_save
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

function temp.replace_data(file_path, tbl)
    local old_data = temp.get_data_from_file(file_path)
    temp.set_data(file_path, tbl)
    if old_data == nil then
        return nil
    end
    return old_data
end

function temp.get_data_from_file(sfile)
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
    if tables[1] ~= nil then
        return tables[1]['value']
    else
        return nil
    end
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
-- NOTE: Deprecated because similarity to root_api.list_dir function
-- function utils.scandir(directory)
--
-- --     print('scandir...')
--     local i, t = 0, {}
--     --print('ls -a "'..directory..'"')
-- --     local pfile = popen('ls -a "' .. directory .. '"')
--     local pfile = temp.get_data(directory, 2)
--
--     utils.dump(pfile)
--     --print(pfile:lines())
--     for filename in pfile:lines() do
--         --print(filename)
--         i = i + 1
--         t[i] = filename
--     end
--     return t
-- end

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

-- function parsers_helpers.parse_list_dir_to_links(data)
--     -- input - data of 'ls -la'
--     -- output - parses an output data of the command 'ls -la' to keys and
--     -- values of the links in this list
--     local list_dir = data
--     local parsed_links = {}
--     for k, v in pairs(list_dir) do
--         split_v = utils.split(v, '>')
--         split_new_k = utils.split(split_v[1], ' ')
--         if split_new_k[9] ~= nil then
--             parsed_links[split_new_k[9]] = split_v[2]
--         end
--     end
--     return parsed_links
-- end

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
local temp_exe_pids_data = 'temp_exe_pids_data'
local temp_pids_data = 'temp_pids_data'

function rules_helpers.get_exe_pids()
    -- returns a table of exe's, and for each exe a list of it's pid's.

    -- try to load old data (in future the data we'll store the data in the C++ module cache and ask for it via the get_data)
    -- In future all cache mechanism will be managed by the C++ module.

    local new_pids = temp.get_data('/proc', temp.root_api_operations.LIST_DIR)
    local old_pids = temp.replace_data(temp_pids_data, new_pids)

    -- checks whether to ask for new exe's list
    local get_new_exes = false
    if old_pids == nil then
        old_pids = {}
    end
    if #new_pids == #old_pids then
        for i = 1, #new_pids do
            if new_pids[i] ~= old_pids[i] then
                print("[Lua] [cyberlib.rules_helpers.get_exe_pids] getting new exes...")
                get_new_exes = true
                break
            end
        end
    else
        print("[Lua] [cyberlib.rules_helpers.get_exe_pids] getting new exes...")
        get_new_exes = true
    end

    local exe_pids = {}
    if get_new_exes == false then
        exe_pids = temp.get_data_from_file(temp_exe_pids_data)
        if exe_pids ~= nil then
            print("[Lua] [cyberlib.rules_helpers.get_exe_pids] no change in pid list, return old exes...")
            return exe_pids
        else
            print("[Lua] [cyberlib.rules_helpers.get_exe_pids] getting new exes...")
        end
    end
    for i, filename in pairs(new_pids) do
        pid = tonumber(filename)
        if (pid ~= nil) then
            local exe = temp.get_data('/proc/' .. pid .. '/exe', 3)
            if exe ~= nil then
                if exe_pids[exe] == nil then
                    exe_pids[exe] = { pid }
                else
                    table.insert(exe_pids[exe], pid)
                end
            end
        end
    end
    temp.set_data(temp_exe_pids_data, exe_pids)
    return exe_pids
end

------------------------------------------------------------------------------

-- helper function for the main_parser.lua file that parser a data path (i.e '/proc/123/status') to
-- parser path (i.e '/proc/pid/status')
function main_parser_helpers.format_data_path_to_parser_path(data_path)
    if data_path == nil then
        print("[Lua] [cyberlib] data_path is 'nil', illegal data_path value!")
        return data_path
    end
    local split_data_path = utils.split(data_path, '/')
    if split_data_path == nil or #split_data_path < 3 then
        return data_path
    end
    local possible_pid = split_data_path[2]
    local possible_pid = possible_pid:match("^%-?%d+$")
    if possible_pid == nil then
        return data_path
    else
        local new_path = '/' .. split_data_path[1] .. '/pid'
        for i = 3, #split_data_path do
            new_path = new_path .. '/' .. split_data_path[i]
        end
        return new_path
    end
end

------------------------------------------------------------------------------
-- lambda function for parsers
lambdas.id = function(v) return v end
lambdas.decstrtodecnumber = function(v) return tonumber(v) end
lambdas.hexstrtodecnumber = function(v) return tonumber(v, 16) end
lambdas.str_at = function(str, index) return string.sub(str, index, index) end
lambdas.list_to_list_of_numbers = function(list) for k, v in pairs(list) do list[k] = tonumber(v) end return list end
lambdas.list_to_number_and_id = function(list) return {[1] = tonumber(list[1]), [2] = list[2]} end
lambdas.list_first_value_to_number = function(list) return tonumber(list[1]) end
lambdas.list_first_value_to_id = function(list) return list[1] end
lambdas.list_first_value_from_hex_to_dec = function(list) return tonumber(list[1], 16) end

return cyberlib

--
--/proc/[pid]/status
--Provides much of the information in /proc/[pid]/stat and
--/proc/[pid]/statm in a format that's easier for humans to
--              parse.  Here's an example:
--
--$ cat /proc/$$/status
--Name:   bash
--Umask:  0022
--State:  S (sleeping)
--Tgid:   17248
--Ngid:   0
--Pid:    17248
--PPid:   17200
--TracerPid:      0
--Uid:    1000    1000    1000    1000
--Gid:    100     100     100     100
--FDSize: 256
--Groups: 16 33 100
--NStgid: 17248
--NSpid:  17248
--NSpgid: 17248
--NSsid:  17200
--VmPeak:     131168 kB
--VmSize:     131168 kB
--VmLck:           0 kB
--VmPin:           0 kB
--VmHWM:       13484 kB
--VmRSS:       13484 kB
--RssAnon:     10264 kB
--RssFile:      3220 kB
--RssShmem:        0 kB
--VmData:      10332 kB
--VmStk:         136 kB
--VmExe:         992 kB
--VmLib:        2104 kB
--VmPTE:          76 kB
--VmPMD:          12 kB
--VmSwap:          0 kB
--HugetlbPages:          0 kB        # 4.4
--CoreDumping:   0                       # 4.15
--Threads:        1
--SigQ:   0/3067
--SigPnd: 0000000000000000
--ShdPnd: 0000000000000000
--SigBlk: 0000000000010000
--SigIgn: 0000000000384004
--SigCgt: 000000004b813efb
--CapInh: 0000000000000000
--CapPrm: 0000000000000000
--CapEff: 0000000000000000
--CapBnd: ffffffffffffffff
--CapAmb:   0000000000000000
--NoNewPrivs:     0
--Seccomp:        0
--Speculation_Store_Bypass:       vulnerable
--Cpus_allowed:   00000001
--Cpus_allowed_list:      0
--Mems_allowed:   1
--Mems_allowed_list:      0
--voluntary_ctxt_switches:        150
--nonvoluntary_ctxt_switches:     545

-- output example:

-- 	VmPeak={
-- 		0,
-- 		'kB'
-- 	},
-- 	Tgid=9202,
-- 	Mems_allowed=1,
-- 	SigPnd=0,
-- 	VmRSS={
-- 		2796,
-- 		'kB'
-- 	},
-- 	Name='bash',
-- 	VmLib={
-- 		0,
-- 		'kB'
-- 	},
-- 	FDSize=4,
-- 	SigBlk=0,
-- 	Gid={
-- 		1000,
-- 		1000,
-- 		1000,
-- 		1000
-- 	},
-- 	CapPrm=0,
-- 	Uid={
-- 		1000,
-- 		1000,
-- 		1000,
-- 		1000
-- 	},
-- 	Pid=9202,
-- 	VmExe={
-- 		1040,
-- 		'kB'
-- 	},
-- 	State='S',
-- 	TracerPid=0,
-- 	SigIgn=0,
-- 	Mems_allowed_list=0,
-- 	CapEff=0,
-- 	voluntary_ctxt_switches=150,
-- 	CapBnd=137438953471,
-- 	VmStk={
-- 		0,
-- 		'kB'
-- 	},
-- 	ShdPnd=0,
-- 	Threads={
-- 		1
-- 	},
-- 	VmHWM={
-- 		0,
-- 		'kB'
-- 	},
-- 	Cpus_allowed=255,
-- 	SigQ={
-- 		queued_signals=0,
-- 		allowed_queued_signals=0
-- 	},
-- 	PPid=9201,
-- 	Groups={
-- 	},
-- 	SigCgt=0,
-- 	VmData={
-- 		0,
-- 		'kB'
-- 	},
-- 	CapInh=0,
-- 	VmSize={
-- 		15276,
-- 		'kB'
-- 	},
-- 	VmLck={
-- 		0,
-- 		'kB'
-- 	},
-- 	nonvoluntary_ctxt_switches=545,
-- 	VmPTE={
-- 		0,
-- 		'kB'
-- 	}

--
--The fields are as follows:
--
--Name   Command run by this process.  Strings longer than
--TASK_COMM_LEN (16) characters (including the
--terminating null byte) are silently truncated.
--
--Umask  Process umask, expressed in octal with a leading
--zero; see umask(2).  (Since Linux 4.7.)
--
--State  Current state of the process.  One of "R
--                     (running)", "S (sleeping)", "D (disk sleep)", "T
--                     (stopped)", "t (tracing stop)", "Z (zombie)", or "X
--                     (dead)".
--
--Tgid   Thread group ID (i.e., Process ID).
--
--Ngid   NUMA group ID (0 if none; since Linux 3.13).
--
--Pid    Thread ID (see gettid(2)).
--
--PPid   PID of parent process.
--
--TracerPid
--PID of process tracing this process (0 if not being
--traced).
--
--Uid, Gid
--Real, effective, saved set, and filesystem UIDs
--(GIDs).
--
--FDSize Number of file descriptor slots currently
--allocated.
--
--Groups Supplementary group list.
--
--NStgid Thread group ID (i.e., PID) in each of the PID
--namespaces of which [pid] is a member.  The
--leftmost entry shows the value with respect to the
--PID namespace of the process that mounted this
--procfs (or the root namespace if mounted by the
--kernel), followed by the value in successively
--nested inner namespaces.  (Since Linux 4.1.)
--
--NSpid  Thread ID in each of the PID namespaces of which
--[pid] is a member.  The fields are ordered as for
--NStgid.  (Since Linux 4.1.)
--
--NSpgid Process group ID in each of the PID namespaces of
--which [pid] is a member.  The fields are ordered as
--for NStgid.  (Since Linux 4.1.)
--
--NSsid  descendant namespace session ID hierarchy Session
--ID in each of the PID namespaces of which [pid] is
--a member.  The fields are ordered as for NStgid.
--(Since Linux 4.1.)
--
--VmPeak Peak virtual memory size.
--
--VmSize Virtual memory size.
--
--VmLck  Locked memory size (see mlock(2)).
--
--VmPin  Pinned memory size (since Linux 3.2).  These are
--pages that can't be moved because something needs
--                     to directly access physical memory.
--
--              VmHWM  Peak resident set size ("high water mark").  This
--                     value is inaccurate; see /proc/[pid]/statm above.
--
--              VmRSS  Resident set size.  Note that the value here is the
--                     sum of RssAnon, RssFile, and RssShmem.  This value
--                     is inaccurate; see /proc/[pid]/statm above.
--
--              RssAnon
--                     Size of resident anonymous memory.  (since Linux
--                     4.5).  This value is inaccurate; see
--                     /proc/[pid]/statm above.
--
--              RssFile
--                     Size of resident file mappings.  (since Linux 4.5).
--                     This value is inaccurate; see /proc/[pid]/statm
--                     above.
--
--              RssShmem
--                     Size of resident shared memory (includes System V
--                     shared memory, mappings from tmpfs(5), and shared
--                     anonymous mappings).  (since Linux 4.5).
--
--              VmData, VmStk, VmExe
--                     Size of data, stack, and text segments.  This value
--                     is inaccurate; see /proc/[pid]/statm above.
--
--              VmLib  Shared library code size.
--
--              VmPTE  Page table entries size (since Linux 2.6.10).
--
--              VmPMD  Size of second-level page tables (added in Linux
--                     4.0; removed in Linux 4.15).
--
--              VmSwap Swapped-out virtual memory size by anonymous
--                     private pages; shmem swap usage is not included
--                     (since Linux 2.6.34).  This value is inaccurate;
--                     see /proc/[pid]/statm above.
--
--              HugetlbPages
--                     Size of hugetlb memory portions (since Linux 4.4).
--
--              CoreDumping
--                     Contains the value 1 if the process is currently
--                     dumping core, and 0 if it is not (since Linux
--                     4.15).  This information can be used by a
--                     monitoring process to avoid killing a process that
--                     is currently dumping core, which could result in a
--                     corrupted core dump file.
--
--              Threads
--                     Number of threads in process containing this
--                     thread.
--
--              SigQ   This field contains two slash-separated numbers
--                     that relate to queued signals for the real user ID
--                     of this process.  The first of these is the number
--                     of currently queued signals for this real user ID,
--                     and the second is the resource limit on the number
--                     of queued signals for this process (see the
--                     description of RLIMIT_SIGPENDING in getrlimit(2)).
--
--              SigPnd, ShdPnd
--                     Mask (expressed in hexadecimal) of signals pending
--                     for thread and for process as a whole (see
--                     pthreads(7) and signal(7)).
--
--              SigBlk, SigIgn, SigCgt
--                     Masks (expressed in hexadecimal) indicating signals
--                     being blocked, ignored, and caught (see signal(7)).
--
--              CapInh, CapPrm, CapEff
--                     Masks (expressed in hexadecimal) of capabilities
--                     enabled in inheritable, permitted, and effective
--                     sets (see capabilities(7)).
--
--              CapBnd Capability bounding set, expressed in hexadecimal
--                     (since Linux 2.6.26, see capabilities(7)).
--
--              CapAmb Ambient capability set, expressed in hexadecimal
--                     (since Linux 4.3, see capabilities(7)).
--
--              NoNewPrivs
--                     Value of the no_new_privs bit (since Linux 4.10,
--                     see prctl(2)).
--
--              Seccomp
--                     Seccomp mode of the process (since Linux 3.8, see
--                     seccomp(2)).  0 means SECCOMP_MODE_DISABLED; 1
--                     means SECCOMP_MODE_STRICT; 2 means
--                     SECCOMP_MODE_FILTER.  This field is provided only
--                     if the kernel was built with the CONFIG_SECCOMP
--                     kernel configuration option enabled.
--
--              Speculation_Store_Bypass
--                     Speculation flaw mitigation state (since Linux
--                     4.17, see prctl(2)).
--
--              Cpus_allowed
--                     Hexadecimal mask of CPUs on which this process may
--                     run (since Linux 2.6.24, see cpuset(7)).
--
--              Cpus_allowed_list
--                     Same as previous, but in "list format" (since Linux
--                     2.6.26, see cpuset(7)).
--
--              Mems_allowed
--                     Mask of memory nodes allowed to this process (since
--                     Linux 2.6.24, see cpuset(7)).
--
--              Mems_allowed_list
--                     Same as previous, but in "list format" (since Linux
--                     2.6.26, see cpuset(7)).
--
--              voluntary_ctxt_switches, nonvoluntary_ctxt_switches
--                     Number of voluntary and involuntary context
--                     switches (since Linux 2.6.23).

local keys_lambdas = {
    ['Name'] = cyberlib.lambdas.list_first_value_to_id,
    ['Umask'] = cyberlib.lambdas.list_first_value_to_id,
    ['State'] = cyberlib.lambdas.list_first_value_to_id,
    ['Tgid'] = cyberlib.lambdas.list_first_value_to_number,
    ['Ngid'] = cyberlib.lambdas.list_first_value_to_number,
    ['Pid'] = cyberlib.lambdas.list_first_value_to_number,
    ['PPid'] = cyberlib.lambdas.list_first_value_to_number,
    ['TracerPid'] = cyberlib.lambdas.list_first_value_to_number,
    ['Uid'] = cyberlib.lambdas.list_to_list_of_numbers,
    ['Gid'] = cyberlib.lambdas.list_to_list_of_numbers,
    ['FDSize'] = cyberlib.lambdas.list_first_value_to_number,
    ['Groups'] = cyberlib.lambdas.list_to_list_of_numbers,
    ['NStgid'] = cyberlib.lambdas.list_first_value_to_number,
    ['NSpid'] = cyberlib.lambdas.list_first_value_to_number,
    ['NSpgid'] = cyberlib.lambdas.list_first_value_to_number,
    ['NSsid'] = cyberlib.lambdas.list_first_value_to_number,
    ['VmPeak'] = cyberlib.lambdas.list_to_number_and_id,
    ['VmSize'] = cyberlib.lambdas.list_to_number_and_id,
    ['VmLck'] = cyberlib.lambdas.list_to_number_and_id,
    ['VmPin'] = cyberlib.lambdas.list_to_number_and_id,
    ['VmHWM'] = cyberlib.lambdas.list_to_number_and_id,
    ['VmRSS'] = cyberlib.lambdas.list_to_number_and_id,
    ['RssAnon'] = cyberlib.lambdas.list_to_number_and_id,
    ['RssFile'] = cyberlib.lambdas.list_to_number_and_id,
    ['RssShmem'] = cyberlib.lambdas.list_to_number_and_id,
    ['VmData'] = cyberlib.lambdas.list_to_number_and_id,
    ['VmStk'] = cyberlib.lambdas.list_to_number_and_id,
    ['VmExe'] = cyberlib.lambdas.list_to_number_and_id,
    ['VmLib'] = cyberlib.lambdas.list_to_number_and_id,
    ['VmPTE'] = cyberlib.lambdas.list_to_number_and_id,
    ['VmPMD'] = cyberlib.lambdas.list_to_number_and_id,
    ['VmSwap'] = cyberlib.lambdas.list_to_number_and_id,
    ['HugetlbPages'] = cyberlib.lambdas.list_to_number_and_id,
    ['CoreDumping'] = cyberlib.lambdas.list_first_value_to_number,
    ['Threads'] = cyberlib.lambdas.list_to_number_and_id,
    ['SigQ'] = function(list) return {['queued_signals'] = tonumber((cyberlib.utils.split(list[1], '/'))[1]), ['allowed_queued_signals'] = tonumber((cyberlib.utils.split(list[1], '/'))[2])} end,
    ['SigPnd'] = cyberlib.lambdas.list_first_value_from_hex_to_dec,
    ['ShdPnd'] = cyberlib.lambdas.list_first_value_from_hex_to_dec,
    ['SigBlk'] = cyberlib.lambdas.list_first_value_from_hex_to_dec,
    ['SigIgn'] = cyberlib.lambdas.list_first_value_from_hex_to_dec,
    ['SigCgt'] = cyberlib.lambdas.list_first_value_from_hex_to_dec,
    ['CapInh'] = cyberlib.lambdas.list_first_value_from_hex_to_dec,
    ['CapPrm'] = cyberlib.lambdas.list_first_value_from_hex_to_dec,
    ['CapEff'] = cyberlib.lambdas.list_first_value_from_hex_to_dec,
    ['CapBnd'] = cyberlib.lambdas.list_first_value_from_hex_to_dec,
    ['CapAmb'] = cyberlib.lambdas.list_first_value_from_hex_to_dec,
    ['NoNewPrivs'] = cyberlib.lambdas.list_first_value_to_number,
    ['Seccomp'] = cyberlib.lambdas.list_first_value_to_number,
    ['Speculation_Store_Bypass'] = cyberlib.lambdas.list_first_value_to_id,
    ['Cpus_allowed'] = cyberlib.lambdas.list_first_value_from_hex_to_dec,
    ['Cpus_allowed_list'] = cyberlib.lambdas.list_first_value_to_number,
    ['Mems_allowed'] = cyberlib.lambdas.list_first_value_to_number,
    ['Mems_allowed_list'] = cyberlib.lambdas.list_first_value_to_number,
    ['voluntary_ctxt_switches'] = cyberlib.lambdas.list_first_value_to_number,
    ['nonvoluntary_ctxt_switches'] = cyberlib.lambdas.list_first_value_to_number
}


print("[Lua] [/proc/<pid>/status] running...")

-- Add {PROJECT_DIR}/lua to LUA_PATH (assuming executable runs in {PROJECT_DIR}/cmake-build-debug)
package.path = package.path .. ";./lua/?.lua"
local cyberlib = require ('cyberlib') -- from {PROJECT_DIR}/lua/cyberlib.lua

name = "status"

function parse(data)
    print("[Lua] [/proc/<pid>/status] parse(data) "..name.."...")
    local parsed_data = cyberlib.parsers_helpers.parse_lines_to_keys_and_lists(data)
    local new_parsed_data = {}
    for key, list in pairs(parsed_data) do
        if keys_lambdas[key] ~= nil then
            new_parsed_data[key] = keys_lambdas[key](list)
        else
            print("[Lua] [/proc/<pid>/status] parse(data) unknown key:"..key.."...")
        end    
    end
    return new_parsed_data
end

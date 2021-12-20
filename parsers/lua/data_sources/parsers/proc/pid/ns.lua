--        /proc/[pid]/ns/ (since Linux 3.0)
--               This is a subdirectory containing one entry for each
--               namespace that supports being manipulated by setns(2).
--               For more information, see namespaces(7).

--    The /proc/[pid]/ns/ directory
--        Each process has a /proc/[pid]/ns/ subdirectory containing one
--        entry for each namespace that supports being manipulated by
--        setns(2):
--
--            $ ls -l /proc/$$/ns | awk '{print $1, $9, $10, $11}'
--            total 0
--            lrwxrwxrwx. cgroup -> cgroup:[4026531835]
--            lrwxrwxrwx. ipc -> ipc:[4026531839]
--            lrwxrwxrwx. mnt -> mnt:[4026531840]
--            lrwxrwxrwx. net -> net:[4026531969]
--            lrwxrwxrwx. pid -> pid:[4026531836]
--            lrwxrwxrwx. pid_for_children -> pid:[4026531834]
--            lrwxrwxrwx. time -> time:[4026531834]
--            lrwxrwxrwx. time_for_children -> time:[4026531834]
--            lrwxrwxrwx. user -> user:[4026531837]
--            lrwxrwxrwx. uts -> uts:[4026531838]
--
--        Bind mounting (see mount(2)) one of the files in this directory
--        to somewhere else in the filesystem keeps the corresponding
--        namespace of the process specified by pid alive even if all
--        processes currently in the namespace terminate.
--
--        Opening one of the files in this directory (or a file that is
--        bind mounted to one of these files) returns a file handle for the
--        corresponding namespace of the process specified by pid.  As long
--        as this file descriptor remains open, the namespace will remain
--        alive, even if all processes in the namespace terminate.  The
--        file descriptor can be passed to setns(2).
--
--        In Linux 3.7 and earlier, these files were visible as hard links.
--        Since Linux 3.8, they appear as symbolic links.  If two processes
--        are in the same namespace, then the device IDs and inode numbers
--        of their /proc/[pid]/ns/xxx symbolic links will be the same; an
--        application can check this using the stat.st_dev and stat.st_ino
--        fields returned by stat(2).  The content of this symbolic link is
--        a string containing the namespace type and inode number as in the
--        following example:
--
--            $ readlink /proc/$$/ns/uts
--            uts:[4026531838]
--
--        The symbolic links in this subdirectory are as follows:
--
--        /proc/[pid]/ns/cgroup (since Linux 4.6)
--               This file is a handle for the cgroup namespace of the
--               process.
--
--        /proc/[pid]/ns/ipc (since Linux 3.0)
--               This file is a handle for the IPC namespace of the
--               process.
--
--        /proc/[pid]/ns/mnt (since Linux 3.8)
--               This file is a handle for the mount namespace of the
--               process.
--
--        /proc/[pid]/ns/net (since Linux 3.0)
--               This file is a handle for the network namespace of the
--               process.
--
--        /proc/[pid]/ns/pid (since Linux 3.8)
--               This file is a handle for the PID namespace of the
--               process.  This handle is permanent for the lifetime of the
--               process (i.e., a process's PID namespace membership never
--               changes).
--
--        /proc/[pid]/ns/pid_for_children (since Linux 4.12)
--               This file is a handle for the PID namespace of child
--               processes created by this process.  This can change as a
--               consequence of calls to unshare(2) and setns(2) (see
--               pid_namespaces(7)), so the file may differ from
--               /proc/[pid]/ns/pid.  The symbolic link gains a value only
--               after the first child process is created in the namespace.
--               (Beforehand, readlink(2) of the symbolic link will return
--               an empty buffer.)
--
--        /proc/[pid]/ns/time (since Linux 5.6)
--               This file is a handle for the time namespace of the
--               process.
--
--        /proc/[pid]/ns/time_for_children (since Linux 5.6)
--               This file is a handle for the time namespace of child
--               processes created by this process.  This can change as a
--               consequence of calls to unshare(2) and setns(2) (see
--               time_namespaces(7)), so the file may differ from
--               /proc/[pid]/ns/time.
--
--        /proc/[pid]/ns/user (since Linux 3.8)
--               This file is a handle for the user namespace of the
--               process.
--
--        /proc/[pid]/ns/uts (since Linux 3.0)
--               This file is a handle for the UTS namespace of the
--               process.
--
--        Permission to dereference or read (readlink(2)) these symbolic
--        links is governed by a ptrace access mode
--        PTRACE_MODE_READ_FSCREDS check; see ptrace(2).

 print("[Lua] [/proc/<pid>/ns] running...")

-- Add {PROJECT_DIR}/lua to LUA_PATH (assuming executable runs in {PROJECT_DIR}/cmake-build-debug)
package.path = package.path .. ";./lua/?.lua"
local cyberlib = require ('cyberlib') -- from {PROJECT_DIR}/lua/cyberlib.lua


name = "ns"

function parse(pid)
    print("[Lua] [/proc/" .. pid .. "/ns] parse("..name..")...")
    parsed_data = cyberlib.parse_list_dir_to_links(name, pid)
    return parsed_data
end

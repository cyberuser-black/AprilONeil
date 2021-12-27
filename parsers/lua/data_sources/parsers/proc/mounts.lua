--[[
Table 1-1: Process specific entries in /proc
..............................................................................
 File		Content
 ...       ...
 mounts      Mounted filesystems


$ cat mounts
rootfs / lxfs rw,noatime 0 0
none /dev tmpfs rw,noatime,mode=755 0 0
sysfs /sys sysfs rw,nosuid,nodev,noexec,noatime 0 0
proc /proc proc rw,nosuid,nodev,noexec,noatime 0 0
devpts /dev/pts devpts rw,nosuid,noexec,noatime,gid=5,mode=620 0 0
none /run tmpfs rw,nosuid,noexec,noatime,mode=755 0 0
none /run/lock tmpfs rw,nosuid,nodev,noexec,noatime 0 0
none /run/shm tmpfs rw,nosuid,nodev,noatime 0 0
none /run/user tmpfs rw,nosuid,nodev,noexec,noatime,mode=755 0 0
binfmt_misc /proc/sys/fs/binfmt_misc binfmt_misc rw,relatime 0 0
tmpfs /sys/fs/cgroup tmpfs rw,nosuid,nodev,noexec,relatime,mode=755 0 0
cgroup /sys/fs/cgroup/devices cgroup rw,nosuid,nodev,noexec,relatime,devices 0 0
C:\134 /mnt/c drvfs rw,noatime,uid=1000,gid=1000,case=off 0 0
D:\134 /mnt/d drvfs rw,noatime,uid=1000,gid=1000,case=off 0 0
]]

-- output example:

-- 		file_system_mount_options={
-- 			rw='rw',
-- 			noatime='noatime'
-- 		},
-- 		file_system_type='lxfs',
-- 		file_system_checks_order=0,
-- 		file_system_spec='rootfs',
-- 		file_system_file='/',
-- 		file_system_need_to_be_dumped=0
-- 	},
-- 	{
-- 		file_system_mount_options={
-- 			rw='rw',
-- 			mode=755,
-- 			noatime='noatime'
-- 		},
-- 		file_system_type='tmpfs',
-- 		file_system_checks_order=0,
-- 		file_system_spec='none',
-- 		file_system_file='/dev',
-- 		file_system_need_to_be_dumped=0
-- 	},
-- 	{
-- 		file_system_mount_options={
-- 			rw='rw',
-- 			nosuid='nosuid',
-- 			noexec='noexec',
-- 			noatime='noatime',
-- 			nodev='nodev'
-- 		},
-- 		file_system_type='sysfs',
-- 		file_system_checks_order=0,
-- 		file_system_spec='sysfs',
-- 		file_system_file='/sys',
-- 		file_system_need_to_be_dumped=0
-- 	},
-- 	{
-- 		file_system_mount_options={
-- 			rw='rw',
-- 			nosuid='nosuid',
-- 			noexec='noexec',
-- 			noatime='noatime',
-- 			nodev='nodev'
-- 		},
-- 		file_system_type='proc',
-- 		file_system_checks_order=0,
-- 		file_system_spec='proc',
-- 		file_system_file='/proc',
-- 		file_system_need_to_be_dumped=0
-- 	},
-- 	{
-- 		file_system_mount_options={
-- 			rw='rw',
-- 			mode=620,
-- 			nosuid='nosuid',
-- 			gid=5,
-- 			noatime='noatime',
-- 			noexec='noexec'
-- 		},
-- 		file_system_type='devpts',
-- 		file_system_checks_order=0,
-- 		file_system_spec='devpts',
-- 		file_system_file='/dev/pts',
-- 		file_system_need_to_be_dumped=0
-- 	},
-- 	{
-- 		file_system_mount_options={
-- 			rw='rw',
-- 			mode=755,
-- 			nosuid='nosuid',
-- 			noatime='noatime',
-- 			noexec='noexec'
-- 		},
-- 		file_system_type='tmpfs',
-- 		file_system_checks_order=0,
-- 		file_system_spec='none',
-- 		file_system_file='/run',
-- 		file_system_need_to_be_dumped=0
-- 	},
-- 	{
-- 		file_system_mount_options={
-- 			rw='rw',
-- 			nosuid='nosuid',
-- 			noexec='noexec',
-- 			noatime='noatime',
-- 			nodev='nodev'
-- 		},
-- 		file_system_type='tmpfs',
-- 		file_system_checks_order=0,
-- 		file_system_spec='none',
-- 		file_system_file='/run/lock',
-- 		file_system_need_to_be_dumped=0
-- 	},
-- 	{
-- 		file_system_mount_options={
-- 			rw='rw',
-- 			noatime='noatime',
-- 			nosuid='nosuid',
-- 			nodev='nodev'
-- 		},
-- 		file_system_type='tmpfs',
-- 		file_system_checks_order=0,
-- 		file_system_spec='none',
-- 		file_system_file='/run/shm',
-- 		file_system_need_to_be_dumped=0
-- 	},
-- 	{
-- 		file_system_mount_options={
-- 			rw='rw',
-- 			mode=755,
-- 			nosuid='nosuid',
-- 			noexec='noexec',
-- 			noatime='noatime',
-- 			nodev='nodev'
-- 		},
-- 		file_system_type='tmpfs',
-- 		file_system_checks_order=0,
-- 		file_system_spec='none',
-- 		file_system_file='/run/user',
-- 		file_system_need_to_be_dumped=0
-- 	},
-- 	{
-- 		file_system_mount_options={
-- 			rw='rw',
-- 			relatime='relatime'
-- 		},
-- 		file_system_type='binfmt_misc',
-- 		file_system_checks_order=0,
-- 		file_system_spec='binfmt_misc',
-- 		file_system_file='/proc/sys/fs/binfmt_misc',
-- 		file_system_need_to_be_dumped=0
-- 	},
-- 	{
-- 		file_system_mount_options={
-- 			rw='rw',
-- 			mode=755,
-- 			nosuid='nosuid',
-- 			relatime='relatime',
-- 			noexec='noexec',
-- 			nodev='nodev'
-- 		},
-- 		file_system_type='tmpfs',
-- 		file_system_checks_order=0,
-- 		file_system_spec='tmpfs',
-- 		file_system_file='/sys/fs/cgroup',
-- 		file_system_need_to_be_dumped=0
-- 	},
-- 	{
-- 		file_system_mount_options={
-- 			rw='rw',
-- 			nosuid='nosuid',
-- 			devices='devices',
-- 			relatime='relatime',
-- 			noexec='noexec',
-- 			nodev='nodev'
-- 		},
-- 		file_system_type='cgroup',
-- 		file_system_checks_order=0,
-- 		file_system_spec='cgroup',
-- 		file_system_file='/sys/fs/cgroup/devices',
-- 		file_system_need_to_be_dumped=0
-- 	},
-- 	{
-- 		file_system_mount_options={
-- 			rw='rw',
-- 			uid=1000,
-- 			gid=1000,
-- 			noatime='noatime'
-- 		},
-- 		file_system_type='drvfs',
-- 		file_system_checks_order=0,
-- 		file_system_spec='C:\\134',
-- 		file_system_file='/mnt/c',
-- 		file_system_need_to_be_dumped=0
-- 	},
-- 	{
-- 		file_system_mount_options={
-- 			rw='rw',
-- 			uid=1000,
-- 			gid=1000,
-- 			noatime='noatime'
-- 		},
-- 		file_system_type='drvfs',
-- 		file_system_checks_order=0,
-- 		file_system_spec='D:\\134',
-- 		file_system_file='/mnt/d',
-- 		file_system_need_to_be_dumped=0
-- 	},
-- 	{
-- 	}
-- }
-- Process finished with exit code -1073741510 (0xC000013A: interrupted by Ctrl+C)


-- The fields are as follows:

--  The first field (fs_spec).
--        This field describes the block special device, remote filesystem
--        or filesystem image for loop device to be mounted or swap file or
--        swap partition to be enabled.
--
--        For ordinary mounts, it will hold (a link to) a block special
--        device node (as created by mknod(2)) for the device to be
--        mounted, like /dev/cdrom or /dev/sdb7. For NFS mounts, this field
--        is <host>:<dir>, e.g., knuth.aeb.nl:/. For filesystems with no
--        storage, any string can be used, and will show up in df(1)
--        output, for example. Typical usage is proc for procfs; mem, none,
--        or tmpfs for tmpfs. Other special filesystems, like udev and
--        sysfs, are typically not listed in fstab.
--
--        LABEL=<label> or UUID=<uuid> may be given instead of a device
--        name. This is the recommended method, as device names are often a
--        coincidence of hardware detection order, and can change when
--        other disks are added or removed. For example, 'LABEL=Boot' or
--        'UUID=3e6be9de-8139-11d1-9106-a43f08d823a6'. (Use a
--        filesystem-specific tool like e2label(8), xfs_admin(8), or
--        fatlabel(8) to set LABELs on filesystems).
--
--        It’s also possible to use PARTUUID= and PARTLABEL=. These
--        partitions identifiers are supported for example for GUID
--        Partition Table (GPT).
--
--        See mount(8), blkid(8) or lsblk(8) for more details about device
--        identifiers.
--
--        Note that mount(8) uses UUIDs as strings. The string
--        representation of the UUID should be based on lower case
--        characters. But when specifying the volume ID of FAT or NTFS file
--        systems upper case characters are used (e.g UUID="A40D-85E7" or
--        UUID="61DB7756DB7779B3").
--
--    The second field (fs_file).
--        This field describes the mount point (target) for the filesystem.
--        For swap partitions, this field should be specified as `none'. If
--        the name of the mount point contains spaces or tabs these can be
--        escaped as `\040' and '\011' respectively.
--
--    The third field (fs_vfstype).
--        This field describes the type of the filesystem. Linux supports
--        many filesystem types: ext4, xfs, btrfs, f2fs, vfat, ntfs,
--        hfsplus, tmpfs, sysfs, proc, iso9660, udf, squashfs, nfs, cifs,
--        and many more. For more details, see mount(8).
--
--        An entry swap denotes a file or partition to be used for
--        swapping, cf. swapon(8). An entry none is useful for bind or move
--        mounts.
--
--        More than one type may be specified in a comma-separated list.
--
--        mount(8) and umount(8) support filesystem subtypes. The subtype
--        is defined by '.subtype' suffix. For example 'fuse.sshfs'. It’s
--        recommended to use subtype notation rather than add any prefix to
--        the first fstab field (for example 'sshfs#example.com' is
--        deprecated).
--
--    The fourth field (fs_mntops).
--        This field describes the mount options associated with the
--        filesystem.
--
--        It is formatted as a comma-separated list of options. It contains
--        at least the type of mount (ro or rw), plus any additional
--        options appropriate to the filesystem type (including
--        performance-tuning options). For details, see mount(8) or
--        swapon(8).



print("[Lua] [/proc/mounts] running...")

-- Add {PROJECT_DIR}/lua to LUA_PATH (assuming executable runs in {PROJECT_DIR}/cmake-build-debug)
package.path = package.path .. ";./lua/?.lua"
local cyberlib = require ('cyberlib') -- from {PROJECT_DIR}/lua/cyberlib.lua

name = "mounts"

function parse(data)
    print("[Lua] [/proc/mounts] parse() " .. name .. "...")
    local parsed_data = cyberlib.parsers_helpers.parse_lines_to_lists_of_lists(data)
    local new_parsed_data = {}
    for k, list in pairs(parsed_data) do
        new_parsed_data[k] = {}
        new_parsed_data[k]['file_system_spec'] = list[1]
        new_parsed_data[k]['file_system_file'] = list[2]
        new_parsed_data[k]['file_system_type'] = list[3]
        if list[4] == nil then
            new_parsed_data[k]['file_system_mount_options'] = nil
        else
            local temp_list_split = cyberlib.utils.split(list[4], ',')
            new_list = {}
            for i = 1, #temp_list_split do
                local temp_cell_split = cyberlib.utils.split(temp_list_split[i], '=')
                if #temp_cell_split == 2 then
                    new_list[temp_cell_split[1]] = tonumber(temp_cell_split[2])
                else
                    new_list[temp_cell_split[1]] = temp_cell_split[1]
                end
            end
            new_parsed_data[k]['file_system_mount_options'] = new_list
        end
        new_parsed_data[k]['file_system_need_to_be_dumped'] = tonumber(list[5])
        new_parsed_data[k]['file_system_checks_order'] = tonumber(list[6])
    end
    return new_parsed_data
end

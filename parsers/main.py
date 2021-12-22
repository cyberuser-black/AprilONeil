import subprocess
import os
import time


def run_lua_parser(proc_path: str, io_operation: str = 'open_file', pid: str = 'self'):
    """
    :param proc_path: The path of the parser.
    :param io_operation: The io operation for the parser (open, readlink, list_dir).
    :param pid: The pid to run the parser with.
    """
    while True:
        subprocess.call(['lua', f'{os.getcwd()}/lua/data_sources/parsers/main_parser.lua', proc_path, io_operation, pid])
        time.sleep(3)


def run_lua_rule(rule_name: str):
    """
    :param rule_name: ...
    """
    while True:
        subprocess.call(['lua', f'{os.getcwd()}/lua/rules/{rule_name}.lua'])
        time.sleep(3)


if __name__ == '__main__':
    proc = "/proc/pid/ns"
    run_lua_parser(proc, io_operation='list_dir', pid='1743')

    # rule_name = 'bash_root_instances'
    # run_lua_rule(rule_name)

import subprocess
import os
import time


def run_lua_parser(proc_path: str, io_operation: int = 1):
    """
    :param proc_path: The path of the parser.
    :param io_operation: The io operation for the parser (open, readlink, list_dir).
    :param pid: The pid to run the parser with.
    """
    while True:
        subprocess.call(['lua', f'{os.getcwd()}/lua/data_sources/parsers/python_parser_wrapper.lua', proc_path, str(io_operation)])
        time.sleep(3)


def run_lua_rule(rule_name: str):
    """
    :param rule_name: ...
    """
    while True:
        subprocess.call(['lua', '-e', f"dofile'{os.getcwd()}/lua/rules/{rule_name}.lua' run()"])
        # subprocess.call(['lua', f"{os.getcwd()}/lua/rules/{rule_name}.lua"])
        time.sleep(3)


def test_parser():
    """
    To test a parser, change to pid to a valid pid and the proc_path to the path of the parser you wish to test.
    Don't forget to pass the valid 'io_operation'.
    Possible io operations:
    1 = Open file
    2 = List dir
    3 = Readlink
    4 = List Links Dir (lists all links in dir)
    """
    pid = 9202
    proc_path = f"/proc/vmstat"
    run_lua_parser(proc_path, io_operation=1)


def test_rule():
    """
    To test a rule, change the rule name value to the rule you wish to test.
    """
    # rule_name = 'exe_constant_uid_gid_rule'
    # rule_name = 'exe_maximum_rss_memory_rule'
    # rule_name = 'exe_num_of_threads_rule'
    # rule_name = 'system_cpu_usage_rule'
    # rule_name = 'system_ram_usage_rule'
    # rule_name = 'exe_instances_threads_uid_gid_rss_rule'
    # rule_name = 'system_ram_and_cpu_usage_rule'
    rule_name = 'exes_whitelist_rule'

    run_lua_rule(rule_name)


if __name__ == '__main__':
    # test_parser()
    test_rule()




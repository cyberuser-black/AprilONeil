import subprocess
import os


def run_lua_parser(proc_path: str, pid: str = 'self'):
    subprocess.call(['lua', f'{os.getcwd()}/lua/data_sources/parsers/main_parser.lua', proc_path, pid])


def run_lua_rule(rule_name: str):
    subprocess.call(['lua', f'{os.getcwd()}/lua/rules/{rule_name}.lua', ])


if __name__ == '__main__':
    # proc = "/proc/pid/ns"
    # run_lua_parser(proc, pid='9')

    rule_name = 'bash_root_instances'
    run_lua_rule(rule_name)
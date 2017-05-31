#!/usr/bin/python
from subprocess import check_output
import sys
import time
import os


def get_all_interface():
    output = check_output("sudo ip l", shell=True)
    return output


def set_interface_up(name):
    while True:
        if name in get_all_interface():
            print("sudo ifup %s" % name)
            os.system("sudo ifup %s" % name)
            return
        time.sleep(1)


def main():
    for i in sys.argv[1:]:
        set_interface_up(i)


if __name__ == '__main__':
    main()


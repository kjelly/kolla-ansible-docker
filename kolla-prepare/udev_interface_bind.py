#!/usr/bin/env python

import sys
import subprocess
import json

UDEV_PATH = '.'


TEMPLATE = ('SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*",'
           'ATTR{address}=="%s", ATTR{type}=="1", KERNEL=="*", NAME="%s"\n')


def get_host_info():
    with open(sys.argv[1], 'r') as ftr:
        return json.load(ftr)


def get_all_mac_address():
    ret = []
    output = subprocess.check_output("sudo ip l", shell=True).strip().split('\n')
    for i in xrange(0, len(output), 2):
        first_line = output[i].strip().split(':')
        second_line = output[i+1].strip().split(' ')
        mac = second_line[1]
        ret.append(mac)
    return ret


def generate_rules():
    all_mac_address = get_all_mac_address()
    host_info = get_host_info()
    host_list = host_info['host_list']
    host = None
    for host in host_list:
        for i in all_mac_address:
            if i in host:
                break
    if host is None:
        print('mac not found')
        return
    content = ''
    for i in host:
        content += TEMPLATE % (i, host[i])
    with open("/etc/udev/rules.d/50-interface-rename.rules", 'w') as ftr:
        ftr.write(content)


def main():
    generate_rules()


if __name__ == '__main__':
    main()

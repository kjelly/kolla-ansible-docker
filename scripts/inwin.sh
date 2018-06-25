#!/bin/bash

script=$1
shift

ansible-playbook -e@/kolla-ansible/ansible/group_vars/all.yml -e@/etc/kolla/globals.yml -i /etc/kolla-ansible-docker/inventory /kolla-prepare/$1 $@

#!/bin/bash

ansible-playbook -e@/etc/kolla-ansible-docker/net-config.yaml -i /etc/kolla-ansible-docker/inventory /kolla-prepare/network-config.yaml $@

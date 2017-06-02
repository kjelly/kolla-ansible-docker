#!/bin/bash

ansible-playbook -i /etc/kolla-ansible-docker/inventory /kolla-prepare/kolla-prepare.yml

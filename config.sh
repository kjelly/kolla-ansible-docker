#!/bin/bash
docker exec -it kolla-ansible-docker cp /kolla-ansible/etc/kolla/globals.yml /etc/kolla/
docker exec -it kolla-ansible-docker cp /kolla-ansible/etc/kolla/passwords.yml /etc/kolla/
docker exec -it kolla-ansible-docker cp /inventory /etc/kolla-ansible-docker/
docker exec -it kolla-ansible-docker /kolla-ansible/tools/generate_passwords.py

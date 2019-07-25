#!/bin/bash
NAME=$1
shift
if [[ -z "${NAME// }" ]]
then
  echo "請提供一個參數，作為名字"
  exit
fi

sudo docker exec $NAME-ansible-docker cp /kolla-ansible/etc/kolla/globals.yml /etc/kolla/
sudo docker exec $NAME-ansible-docker cp /kolla-ansible/etc/kolla/passwords.yml /etc/kolla/
sudo docker exec $NAME-ansible-docker cp /inventory /etc/kolla-ansible-docker/
sudo docker exec $NAME-ansible-docker mkdir -p /etc/ansible/
sudo docker exec $NAME-ansible-docker cp /kolla-prepare/ansible.cfg /etc/ansible/
sudo docker exec $NAME-ansible-docker /kolla-ansible/tools/generate_passwords.py

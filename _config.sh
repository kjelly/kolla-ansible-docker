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
sudo docker exec $NAME-ansible-docker bash -c "cat /inventory_header /kolla-ansible/ansible/inventory/multinode > /etc/kolla-ansible-docker/inventory"
sudo docker exec $NAME-ansible-docker mkdir -p /etc/ansible/
sudo docker exec $NAME-ansible-docker cp /kolla-prepare/ansible.cfg /etc/ansible/
sudo docker exec $NAME-ansible-docker cp /kolla-prepare/net-config.yaml /etc/kolla-ansible-docker/
sudo docker exec $NAME-ansible-docker /kolla-ansible/tools/generate_passwords.py
sudo docker exec $NAME-ansible-docker bash -c "cd /kolla-cli/; python3 cli_setup.py"
sudo docker exec $NAME-ansible-docker rm -f /usr/share/kolla-ansible/ansible/inventory/all-in-one
sudo docker exec $NAME-ansible-docker ln -s /etc/kolla-ansible-docker/inventory /usr/share/kolla-ansible/ansible/inventory/all-in-one

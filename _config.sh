#!/bin/bash
NAME=$1
shift
if [[ -z "${NAME// }" ]]
then
  echo "請提供一個參數，作為名字"
  exit
fi

docker exec -it $NAME-ansible-docker cp /kolla-ansible/etc/kolla/globals.yml /etc/kolla/
docker exec -it $NAME-ansible-docker cp /kolla-ansible/etc/kolla/passwords.yml /etc/kolla/
docker exec -it $NAME-ansible-docker cp /inventory /etc/kolla-ansible-docker/
docker exec -it $NAME-ansible-docker /kolla-ansible/tools/generate_passwords.py

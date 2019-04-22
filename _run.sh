#!/bin/bash
NAME=$1
shift
if [[ -z "${NAME// }" ]]
then
  echo "請提供一個參數，作為名字"
  exit
fi
sudo mkdir -p /etc/$NAME-ansible-docker
sudo mkdir -p /etc/$NAME
docker run --privileged -d --net=host --name $NAME-ansible-docker -v /etc/$NAME:/etc/kolla -v /etc/$NAME-ansible-docker:/etc/kolla-ansible-docker  kolla-ansible-docker

#!/bin/bash
NAME=$1
shift
if [[ -z "${NAME// }" ]]
then
  echo "請提供一個參數，作為名字"
fi

sudo docker exec -t $NAME-ansible-docker $@

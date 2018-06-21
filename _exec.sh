#!/bin/bash
NAME=$1
shift
if [[ -z "${NAME// }" ]]
then
  echo "請提供一個參數，作為名字"
  exit
fi
docker exec -it $NAME-ansible-docker env TERM=xterm-256color script -q -c "/bin/bash" /dev/null
#docker exec -it kolla-ansible-docker /usr/bin/fish

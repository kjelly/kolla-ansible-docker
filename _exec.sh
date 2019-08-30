#!/bin/bash
NAME=$1
shift
if [[ -z "${NAME// }" ]]
then
  echo "請提供一個參數，作為名字"
  exit
fi
sudo docker exec -it --env COLUMNS=`tput cols` --env LINES=`tput lines` --env TERM=xterm-256color $NAME-ansible-docker bash
#docker exec -it kolla-ansible-docker /usr/bin/fish

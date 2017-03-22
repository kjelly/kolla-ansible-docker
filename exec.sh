#!/bin/bash
docker exec -it kolla-ansible-docker env TERM=xterm script -q -c "/bin/bash" /dev/null
#docker exec -it kolla-ansible-docker /usr/bin/fish

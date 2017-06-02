#!/bin/bash
sudo mkdir -p /etc/kolla-ansible-docker
docker run -d --net=host --name kolla-ansible-docker -v /etc/kolla:/etc/kolla -v /etc/kolla-ansible-docker:/etc/kolla-ansible-docker  kolla-ansible-docker

#!/bin/bash
docker run -d --net=host --name kolla-ansible-docker -v /etc/kolla:/etc/kolla -v /etc/kolla-ansible-docker:/etc/kolla-ansible/docker  kolla-ansible-docker

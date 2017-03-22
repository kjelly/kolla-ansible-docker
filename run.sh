#!/bin/bash
docker run -d --net=host --name kolla-ansible-docker -v /etc/kolla:/etc/kolla kolla-ansible-docker

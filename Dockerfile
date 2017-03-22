FROM ubuntu:16.04
MAINTAINER Kuo-tung Kao


RUN apt-get update && \
    apt-get install -y --force-yes git fish python-pip vim

RUN git clone https://github.com/openstack/kolla-ansible /kolla-ansible && \
    pip install -r /kolla-ansible/requirements.txt

CMD ["/bin/sleep", "infinity"]


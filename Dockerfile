FROM ubuntu:16.04
MAINTAINER Kuo-tung Kao


RUN apt-get update && \
    apt-get install -y --force-yes git fish python-pip vim libssl-dev

RUN git clone https://github.com/openstack/kolla-ansible /kolla-ansible -b stable/ocata && \
    pip install -r /kolla-ansible/requirements.txt && \
    pip install --upgrade pip && \
    pip install ansible

ADD deploy.sh /bin/ka
ADD inventory /inventory

RUN chmod +x /bin/deploy

CMD ["/bin/sleep", "infinity"]


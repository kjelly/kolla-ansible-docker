FROM ubuntu:16.04
MAINTAINER Kuo-tung Kao


RUN apt-get update && \
    apt-get install -y --force-yes git fish python-pip vim libssl-dev

ADD kolla-ansible /kolla-ansible

RUN pip install -r /kolla-ansible/requirements.txt && \
    pip install --upgrade pip && \
    pip install ansible

ADD packages /packages

ADD deploy.sh /bin/ka
ADD inventory /inventory
ADD kolla-prepare /kolla-prepare
ADD prepare.sh /bin/prepare

RUN chmod +x /bin/ka
RUN chmod +x /bin/prepare

CMD ["/bin/sleep", "infinity"]


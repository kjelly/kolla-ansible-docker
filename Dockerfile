FROM ubuntu:16.04
MAINTAINER Kuo-tung Kao


RUN apt-get update && \
    apt-get install -y --force-yes git fish python-pip vim libssl-dev

ADD kolla-ansible /kolla-ansible

RUN pip install -r /kolla-ansible/requirements.txt && \
    pip install --upgrade pip && \
    pip install ansible

ADD deploy.sh /bin/ka
ADD inventory /inventory

RUN chmod +x /bin/ka

CMD ["/bin/sleep", "infinity"]


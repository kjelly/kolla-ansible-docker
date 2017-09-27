FROM ubuntu:16.04
MAINTAINER Kuo-tung Kao


RUN apt-get update && \
    apt-get install -y --force-yes git fish python-pip vim libssl-dev libffi-dev

ADD kolla-ansible /kolla-ansible

RUN pip install -r /kolla-ansible/requirements.txt && \
    pip install --upgrade pip && \
    pip install ansible

ADD ssh-config /root/.ssh
ADD packages /packages
ADD kolla-prepare /kolla-prepare

ADD inventory /inventory
ADD scripts /scripts

RUN cp /scripts/* /bin/ && \
    mv /bin/deploy.sh /bin/ka && \
    mv /bin/kolla_prepare.sh /bin/prepare && \
    mv /bin/kolla_post_add_compute_node.sh /bin/post_add_compute_node && \
    chmod +x /bin/ka && \
    chmod +x /bin/prepare && \
    chmod +x /bin/post_add_compute_node



CMD ["/bin/sleep", "infinity"]


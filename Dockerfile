FROM ubuntu:18.04
MAINTAINER Kuo-tung Kao


RUN apt-get update && \
    apt-get install -y --force-yes git fish vim libssl-dev libffi-dev curl python sudo man-db iputils-ping net-tools iproute2 build-essential && \
    pip install -y python-openstackclient python-heatclient gnocchiclient

RUN curl https://raw.githubusercontent.com/kjelly/auto_config/master/scripts/init_nvim.sh|bash && \
    curl https://raw.githubusercontent.com/kjelly/auto_config/master/scripts/init_nvim_nightly.sh |bash && \
    curl https://raw.githubusercontent.com/kjelly/auto_config/master/scripts/init_nvimrc.sh |bash && \
    nvim +PlugInstall +qall

ADD kolla-ansible /kolla-ansible

RUN curl https://bootstrap.pypa.io/get-pip.py |python - && \
    pip install --upgrade pip && \
    pip install -r /kolla-ansible/requirements.txt && \
    pip install ansible

ADD ssh-config /root/.ssh
ADD packages /packages
ADD kolla-prepare /kolla-prepare

ADD inventory /inventory
ADD scripts /scripts

RUN cp /scripts/* /bin/ && \
    mv /bin/deploy.sh /bin/ka && \
    mv /bin/kolla_prepare.sh /bin/prepare && \
    mv /bin/inwin.sh /bin/inwin && \
    mv /bin/kolla_post_add_compute_node.sh /bin/post_add_compute_node && \
    chmod +x /bin/ka && \
    chmod +x /bin/prepare && \
    chmod +x /bin/post_add_compute_node && \
    chmod +x /bin/inwin




CMD ["/bin/sleep", "infinity"]


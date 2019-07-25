FROM ubuntu:18.04
MAINTAINER Kuo-tung Kao

RUN apt-get update && \
    apt-get install -y --force-yes git fish vim libssl-dev libffi-dev curl python2.7-dev sudo man-db build-essential && \
    apt-get install -y --force-yes zsh wget mariadb-client influxdb-client iputils-ping net-tools iproute2

RUN cp /usr/bin/python2.7 /usr/bin/python && \
    curl https://bootstrap.pypa.io/get-pip.py |python - && \
    pip install --upgrade pip && \
    pip install python-openstackclient python-heatclient gnocchiclient

RUN wget -qO- https://raw.githubusercontent.com/kjelly/auto_config/master/scripts/init_nvim_nightly.sh | bash && \
    wget -qO- https://raw.githubusercontent.com/kjelly/auto_config/master/scripts/init_nvim.sh | bash && \
    wget -qO- https://raw.githubusercontent.com/kjelly/auto_config/master/scripts/init_nvimrc.sh |bash  && \
    nvim +PlugInstall +qall!

RUN git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

RUN echo '\n \
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh \n \
autoload -Uz colors \n \
colors \n \
autoload -Uz compinit \n \
compinit \n \
setopt share_history \n \
setopt histignorealldups \n \
setopt auto_cd \n \
setopt auto_pushd \n \
setopt pushd_ignore_dups \n \
setopt correct \n \
PROMPT="%(?.%{${fg[green]}%}.%{${fg[red]}%})%n${reset_color}@${fg[blue]}kolla-ansible${reset_color} %~ %# " \
'>> /root/.zshrc

ADD kolla-ansible /kolla-ansible

RUN pip install -r /kolla-ansible/requirements.txt && \
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

ENV TERM=xterm-256color

CMD ["/bin/sleep", "infinity"]


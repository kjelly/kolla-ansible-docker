FROM ubuntu:18.04
MAINTAINER Kuo-tung Kao

RUN apt-get update

ENV DEBIAN_FRONTEND=noninteractive

RUN apt install -y bash console-setup sudo wget curl git python3 man-db && \
    echo "install console-setup" && \
    echo "console-setup   console-setup/codeset47 select  # Latin1 and Latin5 - western Europe and Turkic languages" | debconf-set-selections && \
    echo "console-setup   console-setup/fontface47        select  Fixed" | debconf-set-selections && \
    echo "console-setup   console-setup/fontsize-text47   select  16" | debconf-set-selections && \
    echo "console-setup   console-setup/charmap47 select  UTF-8" | debconf-set-selections && \
    echo "keyboard-configuration  console-setup/detect    detect-keyboard" | debconf-set-selections && \
    echo "keyboard-configuration  console-setup/detected  note" | debconf-set-selections && \
    echo "console-setup   console-setup/codesetcode       string  Lat15" | debconf-set-selections && \
    echo "keyboard-configuration  console-setup/ask_detect        boolean false" | debconf-set-selections && \
    echo "console-setup   console-setup/store_defaults_in_debconf_db      boolean true" | debconf-set-selections && \
    echo "console-setup   console-setup/fontsize-fb47     select  16" | debconf-set-selections && \
    echo "console-setup   console-setup/fontsize  string  16" | debconf-set-selections

RUN apt-get install -y --force-yes git fish vim silversearcher-ag zsh wget tmux && \
    apt-get install -y --force-yes libssl-dev libffi-dev curl sudo man-db build-essential python3-dev&& \
    apt-get install -y --force-yes mariadb-client influxdb-client iputils-ping net-tools iproute2 ldap-utils ipmitool libguestfs-tools oz

RUN cp /usr/bin/python3 /usr/bin/python && \
    curl https://bootstrap.pypa.io/get-pip.py | python3 - && \
    pip install --upgrade pip && \
    pip install python-openstackclient python-heatclient gnocchiclient aodhclient osc-placement python-ironicclient && \
    pip install ipython


RUN python3 -m pip install pynvim ansible;

RUN git clone https://github.com/kjelly/auto_config /auto_config ; \
    cd /auto_config ; echo {}|./nrun.py -r developer-packages fish vim -a deploy; ls

RUN wget -qO- https://raw.githubusercontent.com/kjelly/auto_config/master/scripts/init_nvim_nightly.sh | bash ; \
    wget -qO- https://raw.githubusercontent.com/kjelly/auto_config/master/scripts/init_nvim.sh | bash ; \
    wget -qO- https://raw.githubusercontent.com/kjelly/auto_config/master/scripts/init_nvimrc.sh | bash ; \
    nvim --headless "+silent! PlugInstall" +qall; ls


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

RUN pip3 install -r /kolla-ansible/requirements.txt && \
    pip3 install ansible && pip3 install ./kolla-ansible

ADD ssh-config /root/.ssh
ADD packages /packages
ADD kolla-prepare /kolla-prepare

ADD inventory_header /inventory_header
ADD scripts /scripts

RUN cp /scripts/* /bin/ && \
    mv /bin/deploy.sh /bin/ka && \
    mv /bin/kolla_prepare.sh /bin/prepare && \
    mv /bin/net-config.sh /bin/net-config && \
    mv /bin/inwin.sh /bin/inwin && \
    mv /bin/kolla_post_add_compute_node.sh /bin/post_add_compute_node && \
    chmod +x /bin/ka && \
    chmod +x /bin/prepare && \
    chmod +x /bin/post_add_compute_node && \
    chmod +x /bin/inwin && \
    cp /kolla-prepare/ansible.cfg /etc/

ENV TERM=xterm-256color

COPY nvim.tar.gz /root/
RUN tar zxvf /root/nvim.tar.gz -C /root/;mkdir -p /root/.vim;

RUN git clone https://github.com/openstack/kolla-cli /kolla-cli -b stable/train &&  cd /kolla-cli/ && \
    python3 setup.py develop && \
    python3 cli_setup.py

#ADD ~/.config/nvim/bin /usr/bin

CMD ["/bin/sleep", "infinity"]


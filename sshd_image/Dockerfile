FROM local/c7.8-systemd

WORKDIR /root
COPY .root_password .
RUN cat .root_password | passwd --stdin root
RUN mkdir -m 700 .ssh
COPY ansible_base_rsa.pub .ssh/authorized_keys
RUN chmod 600 .ssh/authorized_keys
RUN yum -y install openssh-server; yum -y install sed; yum -y install logrotate; \
    yum -y install which; yum -y install sudo; yum -y install rsync; yum clean all;
# root以外でログインができないため以下の対処を入れている。
RUN sed -i -e '/^#PermitRootLogin/d' -e '/^#PasswordAuthentication/d' \
    -e '/^PasswordAuthentication/d' /etc/ssh/sshd_config 1>/dev/null
RUN echo -e "PermitRootLogin yes\nPasswordAuthentication no\n" >> /etc/ssh/sshd_config
RUN sed -i 's/^\(account    required\)/#\1/g' /etc/pam.d/{login,sshd}
RUN useradd deploy_user && usermod -aG wheel deploy_user

WORKDIR /home/deploy_user
COPY .deploy_user_password .
RUN cat .deploy_user_password | passwd --stdin deploy_user
RUN mkdir -m 700 .ssh
## rootと同じ鍵を設定する
COPY ansible_base_rsa.pub .ssh/authorized_keys
RUN chown -R deploy_user:deploy_user .ssh && chmod 600 .ssh/authorized_keys

RUN systemctl enable sshd.service

# Docker経由でContainerに入る場合最後に作業していたディレクトリがCurrentに設定されるため変えている。
WORKDIR /

EXPOSE 22
CMD ["/usr/sbin/init"]

FROM local/c7.8-systemd

COPY .root_password /root/
COPY .deploy_user_password /root/

RUN yum -y install openssh-server; yum -y install sed; yum clean all;
RUN yum -y install which; yum -y install sudo;
RUN sed -i -e '/^#PermitRootLogin/d' -e '/^#PasswordAuthentication/d' \
    -e '/^PasswordAuthentication/d' /etc/ssh/sshd_config 1>/dev/null
RUN echo -e "PermitRootLogin yes\nPasswordAuthentication yes\n" >> /etc/ssh/sshd_config
RUN cat /root/.root_password | passwd --stdin root

RUN useradd deploy_user && usermod -aG wheel deploy_user
RUN cat /root/.deploy_user_password | passwd --stdin deploy_user
# root以外でログインができないため以下の対処を入れている。
RUN sed -i 's/^\(account    required\)/#\1/g' /etc/pam.d/{login,sshd}

RUN systemctl enable sshd.service

EXPOSE 22
CMD ["/usr/sbin/init"]

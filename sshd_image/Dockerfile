FROM local/c7.8-systemd

COPY .root_password /root/

RUN yum -y install openssh-server; yum -y install sed; yum clean all;
RUN sed -i -e '/^#PermitRootLogin/d' -e '/^#PasswordAuthentication/d' \
    -e '/^PasswordAuthentication/d' /etc/ssh/sshd_config 1>/dev/null
RUN echo -e "PermitRootLogin yes\nPasswordAuthentication yes\n" >> /etc/ssh/sshd_config
RUN cat /root/.root_password | passwd --stdin root
RUN systemctl enable sshd.service

EXPOSE 22
CMD ["/usr/sbin/init"]

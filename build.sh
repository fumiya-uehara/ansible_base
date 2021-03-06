#!/bin/bash
docker build --rm -t local/c7.8-systemd ./base_image
docker build --rm -t local/c7.8-systemd-sshd ./sshd_image
sed -i -e '/^\[localhost\]:12222/d' ~/.ssh/known_hosts
docker run -d --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p 12222:22 --name ansible_base local/c7.8-systemd-sshd
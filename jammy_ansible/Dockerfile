# Use BuildKit syntax for multiarch support
# syntax = docker/dockerfile:1.4

FROM ubuntu:22.04

ENV pip_packages="ansible-core==2.16.3 pyopenssl"

# install python 3.11
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
      python3.11-dev \
      python3-pip \
      openssh-server \
      net-tools sudo \
    && rm -Rf /var/lib/apt/lists/* \
    && rm -Rf /usr/share/doc && rm -Rf /usr/share/man \
    && apt-get clean

# Install Ansible via Pip.
RUN pip install -U pip
RUN pip install $pip_packages

# copy collections file
COPY collections.yaml /

# install ansible collections
RUN ansible-galaxy collection install -r /collections.yaml

# Install Ansible inventory file.
RUN mkdir -p /etc/ansible
RUN echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts

VOLUME ["/sys/fs/cgroup", "/tmp", "/run"]
CMD ["/sbin/my_init"]


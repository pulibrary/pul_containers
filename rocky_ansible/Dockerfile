# Use BuildKit syntax for multiarch support
# syntax = docker/dockerfile:1.4

FROM rockylinux:9

# Install Python 3.11 and other necessary packages
RUN yum install -y epel-release \
    && yum update -y \
    && yum install -y \
        python3.11 \
        python3.11-pip \
        openssh-server \
        net-tools \
        sudo \
    && yum clean all

# Install Ansible via Pip
RUN pip3.11 install -U pip
RUN pip3.11 install "ansible-core==2.16.3"
RUN pip3.11 install "pyopenssl"

# Copy collections file
COPY collections.yaml /

# Install Ansible collections
RUN ansible-galaxy collection install -r /collections.yaml

# Install Ansible inventory file
RUN mkdir -p /etc/ansible
RUN echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts

VOLUME ["/sys/fs/cgroup", "/tmp", "/run"]

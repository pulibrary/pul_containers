# Use BuildKit syntax for multiarch support
# syntax = docker/dockerfile:1.4

FROM ubuntu:22.04

ENV pip_packages="ansible-core==2.16.3 pyopenssl"

# Install Python 3.11, pip, and necessary packages in one layer
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      python3.11-dev \
      python3-pip \
      openssh-server \
      net-tools \
      sudo && \
    pip install -U pip && \
    pip install $pip_packages && \
    # Clean up APT when done
    apt-get remove --purge -y python3-pip && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc /usr/share/man && \
    apt-get clean

# Copy collections file and install ansible collections
COPY collections.yaml /
RUN ansible-galaxy collection install -r /collections.yaml && rm /collections.yaml

# Install Ansible inventory file
RUN mkdir -p /etc/ansible && \
    echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts

# Define volumes
VOLUME ["/sys/fs/cgroup", "/tmp", "/run"]

CMD ["/sbin/my_init"]

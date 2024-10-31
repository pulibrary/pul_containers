# syntax = docker/dockerfile:1.4
# Define architectures
ARG TARGETARCH=linux/amd64

# Use appropriate base image based on architecture
FROM --platform=$TARGETARCH ubuntu:22.04

# Install dependencies and clean up
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
      python3.11-dev \
      python3-pip \
      openssh-server \
      net-tools \
      sudo \
      systemd \
    && rm -Rf /var/lib/apt/lists/* \
    && rm -Rf /usr/share/doc && rm -Rf /usr/share/man \
    && apt-get clean

# Install Ansible
RUN pip install -U pip \
    && pip install ansible-core==2.16.3 pyopenssl

# Copy collections file and install collections
COPY collections.yaml /
RUN ansible-galaxy collection install -r /collections.yaml

# Set up Ansible inventory
RUN mkdir -p /etc/ansible
RUN echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts

# Create Ansible temporary directory
RUN mkdir -p /root/.ansible/tmp && chmod -R 777 /root/.ansible/tmp
# Create Ansible temporary directory
#
RUN mkdir -p /tmp/ansible && chmod -R 1777 /tmp/ansible

# Expose SSH port
EXPOSE 22

# Set up entrypoint for systemd
CMD ["/usr/sbin/init"]

# Define volumes
VOLUME ["/sys/fs/cgroup", "/tmp", "/run"]

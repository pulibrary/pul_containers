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
      iproute2 \
      procps \
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

# Create multiple temp directories with proper permissions for Molecule
RUN mkdir -p /root/.ansible/tmp && chmod -R 755 /root/.ansible/tmp
RUN mkdir -p /tmp/ansible && chmod -R 1777 /tmp/ansible
RUN mkdir -p /var/tmp/ansible && chmod -R 1777 /var/tmp/ansible

# Ensure /tmp has proper permissions
RUN chmod 1777 /tmp

# Create ansible user for better compatibility (optional but recommended)
RUN useradd -m -s /bin/bash ansible \
    && echo 'ansible ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    && mkdir -p /home/ansible/.ansible/tmp \
    && chmod -R 755 /home/ansible/.ansible/tmp \
    && chown -R ansible:ansible /home/ansible/.ansible

# Fix systemd for container use
RUN systemctl set-default multi-user.target
RUN systemctl mask dev-hugepages.mount sys-fs-fuse-connections.mount

# Expose SSH port
EXPOSE 22

# Set up entrypoint for systemd - but make it work better in containers
CMD ["/bin/bash", "-c", "exec /usr/sbin/init --log-target=journal 3>&1"]

# Define volumes
VOLUME ["/sys/fs/cgroup", "/tmp", "/run"]

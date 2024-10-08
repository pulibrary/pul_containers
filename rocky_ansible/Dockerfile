# Use a minimal base image
FROM eniocarboni/docker-rockylinux-systemd:latest AS builder

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
RUN pip3.11 install -U pip \
    && pip3.11 install "ansible-core==2.16.3" "pyopenssl" \
    && pip3.11 cache purge \
    && yum remove -y python3.11-pip \
    && yum clean all \
    && rm -rf /var/cache/yum \
    && rm -rf /tmp/* /var/tmp/*

# Copy collections file
COPY collections.yaml /

# Install Ansible collections
RUN ansible-galaxy collection install -r /collections.yaml \
    && rm /collections.yaml

# Create the /tmp/.ansible directory
RUN mkdir -p /root/.ansible/tmp && chmod -R 777 /root/.ansible/tmp


# Final stage: use a fresh image to reduce size
FROM eniocarboni/docker-rockylinux-systemd:latest

# Copy necessary files from the builder stage
COPY --from=builder /usr /usr
COPY --from=builder /etc /etc
COPY --from=builder /root/.ansible /root/.ansible

VOLUME ["/sys/fs/cgroup", "/tmp", "/run"]

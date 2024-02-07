FROM phusion/baseimage:jammy-1.0.2
ENV pip_packages "pipenv ansible pyopenssl"

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


# Install Ansible inventory file.
RUN mkdir -p /etc/ansible
RUN echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts

VOLUME ["/sys/fs/cgroup", "/tmp", "/run"]
CMD ["/sbin/my_init"]

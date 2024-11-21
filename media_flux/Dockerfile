FROM phusion/baseimage:jammy-1.0.1

# install java 18
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    openssh-server \
    openjdk-18-jdk \
    curl \ 
    expect \
    net-tools sudo \
     && apt-get clean


VOLUME ["/sys/fs/cgroup", "/tmp", "/run"]
CMD ["/sbin/my_init"]

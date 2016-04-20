FROM centos:7

VOLUME /sys/fs/cgroup
ENV container docker
RUN yum -y update; yum clean all
RUN yum -y remove fakesystemd \
    && yum -y install \
        automake \
        bash \
        crontabs \
        curl \
        gcc \
        gcc-c++ \
        glibc \
        hostname \
        initscripts \
        iptables \
        kernel-devel \
        make \
        net-tools \
        passwd \
        rsyslog \
        sudo \
        systemd \
        systemd-libs \
        tar \
        which \
    && yum clean all &&\
    (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done) && \
    rm -f /lib/systemd/system/multi-user.target.wants/* && \
    rm -f /etc/systemd/system/*.wants/* && \
    rm -f /lib/systemd/system/local-fs.target.wants/* && \
    rm -f /lib/systemd/system/sockets.target.wants/*udev* && \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl* && \
    rm -f /lib/systemd/system/basic.target.wants/* && \
    rm -f /lib/systemd/system/anaconda.target.wants/* && \

    useradd -d /home/kitchen -m -s /bin/bash kitchen && \
    (echo kitchen:kitchen | chpasswd) && \
    mkdir -p /etc/sudoers.d && \
    echo 'kitchen ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/kitchen && \

    yum -y install openssh-server openssh-clients && yum clean all && \
    ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -N '' && \
    ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' && \
    echo 'OPTIONS="-o UseDNS=no -o UsePAM=no -o PasswordAuthentication=yes"' >> /etc/sysconfig/sshd && \
    systemctl enable sshd.service &&\
    (curl -L https://www.opscode.com/chef/install.sh | bash -s)

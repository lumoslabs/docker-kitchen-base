FROM centos:6

ENV container=docker \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8
RUN yum -y update
RUN yum install -y sudo curl which initscripts net-tools \
    && yum clean all \
    && (curl -L https://www.opscode.com/chef/install.sh | bash -s -- -P chefdk) \
    && ln -vs /opt/chefdk /opt/chef

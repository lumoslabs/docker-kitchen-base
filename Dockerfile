FROM centos:6

ENV container=docker
RUN yum -y update
RUN yum install -y sudo curl \
    && yum clean all \
    && (curl -L https://www.opscode.com/chef/install.sh | bash -s -- -P chefdk) \
    && ln -vs /opt/chefdk /opt/chef

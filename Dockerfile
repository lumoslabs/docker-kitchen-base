FROM centos:6

ENV container=docker \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8
ADD rbenv.sh /etc/profile.d/
RUN yum -y update
RUN yum install -y -d1 -e2 \
      autoconf \
      bison \
      build-essential \
      bzip2 \
      curl \
      flex \
      gcc \
      gcc-c++ \
      gettext \
      git \
      initscripts \
      kernel-devel \
      libxml2-devel \
      libxslt-devel \
      m4 \
      make \
      ncurses-devel \
      net-tools \
      openssl-devel \
      patch \
      readline-devel \
      sudo \
      which \
      zlib-devel \
    && yum clean all
RUN useradd --create-home --shell /bin/bash --home-dir /home/lumoslabs lumoslabs \
    && mkdir -p /opt/rbenv \
    && chmod 2775 /opt/rbenv \
    && chown lumoslabs /opt/rbenv \
    && su -l -c 'git clone --depth 1 https://github.com/sstephenson/rbenv.git /opt/rbenv' lumoslabs \
    && su -l -c 'git clone --depth 1 https://github.com/sstephenson/ruby-build.git /opt/rbenv/plugins/ruby_build' lumoslabs \
    && su -l -c 'source /etc/profile.d/rbenv.sh ; rbenv install -v 2.1.6 ; rbenv global 2.1.6' lumoslabs
    # && rbenv install --verbose 2.1.6 \
    # && rbenv global 2.1.6 \
RUN (curl -L https://www.opscode.com/chef/install.sh | bash -s) \
    && ln -vs /opt/chefdk /opt/chef

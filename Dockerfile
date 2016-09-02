FROM centos:6

ENV container=docker \
    GIT_VERSION=2.8.1 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

RUN yum -y update
RUN yum install -y -d2 -e2 \
      autoconf \
      bison \
      build-essential \
      bzip2 \
      curl \
      curl-devel \
      expat-devel \
      flex \
      gcc \
      gcc-c++ \
      gettext \
      gettext-devel \
      git \
      initscripts \
      kernel-devel \
      libffi \
      libffi-devel \
      libxml2-devel \
      libxslt-devel \
      m4 \
      make \
      ncurses-devel \
      net-tools \
      openssl-devel \
      patch \
      perl-devel \
      readline-devel \
      sudo \
      which \
      zlib-devel \
    && yum clean all

ADD rbenv.sh /etc/profile.d/
ADD https://github.com/git/git/archive/v${GIT_VERSION}.tar.gz /tmp/git.tgz

RUN cd /tmp \
    && tar xvzf git.tgz \
    && cd git-${GIT_VERSION} \
    && make configure \
    && ./configure --prefix=/usr \
    && make all \
    && make install
RUN useradd --create-home --shell /bin/bash --home-dir /home/lumoslabs lumoslabs \
    && mkdir -p /opt/rbenv \
    && chmod 2775 /opt/rbenv \
    && chown lumoslabs /opt/rbenv \
    && su -l -c 'git clone --depth 1 https://github.com/sstephenson/rbenv.git /opt/rbenv' lumoslabs \
    && su -l -c 'git clone --depth 1 https://github.com/sstephenson/ruby-build.git /opt/rbenv/plugins/ruby_build' lumoslabs \
    && su -l -c 'source /etc/profile.d/rbenv.sh ; RUBY_CONFIGURE_OPTS=--disable-install-doc rbenv install -v 2.1.6 ; rbenv global 2.1.6' lumoslabs \
    && su -l -c 'source /etc/profile.d/rbenv.sh ; RUBY_CONFIGURE_OPTS=--disable-install-doc rbenv install -v 2.2.0' lumoslabs
RUN echo 'gem: --no-document' >/root/.gemrc \
    && echo 'gem: --no-document' >/etc/gemrc \
    && su -l -c 'source /etc/profile.d/rbenv.sh ; echo "gem: --no-document" >/home/lumoslabs/.gemrc ; gem install bundler --no-document' lumoslabs
RUN (curl -L https://www.opscode.com/chef/install.sh | bash -s) \
    && ln -vs /opt/chefdk /opt/chef

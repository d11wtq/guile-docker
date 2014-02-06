# Dockerfile for a Scheme project container.
#
# This container provides an environment for running Guile Scheme.

FROM       ubuntu
MAINTAINER Chris Corbyn

RUN apt-get install -qq -y \
  curl             \
  build-essential  \
  man pkg-config   \
  libreadline-dev  \
  libltdl7-dev     \
  libgmp-dev       \
  libunistring-dev \
  libffi-dev       \
  libgc-dev

RUN groupadd admin
RUN useradd -m -s /bin/bash -G admin guile
RUN echo guile:guile | chpasswd

RUN cd /tmp; curl -sO ftp://ftp.gnu.org/gnu/guile/guile-2.0.9.tar.gz
RUN cd /tmp; tar xvzf guile-*.tar.gz; rm guile-*.tar.gz
RUN cd /tmp/guile-*; ./configure && make && make install
RUN cd /tmp; rm -rf guile-*

RUN su guile -c 'echo -e "(use-modules (ice-9 readline))\n(activate-readline)" > ~/.guile'

ENV     LD_LIBRARY_PATH /usr/local/lib
ENV     HOME /home/guile
WORKDIR /home/guile
USER    guile

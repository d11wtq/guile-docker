# Dockerfile for a Scheme project container.
#
# This container provides an environment for running Guile Scheme.

FROM       d11wtq/ubuntu
MAINTAINER Chris Corbyn

ENV LD_LIBRARY_PATH /usr/local/lib

RUN sudo apt-get update -qq -y
RUN sudo apt-get install -qq -y \
  pkg-config       \
  libltdl7-dev     \
  libgmp-dev       \
  libunistring-dev \
  libffi-dev       \
  libgc-dev

ADD http://ftp.gnu.org/gnu/guile/guile-2.0.9.tar.gz /tmp/

RUN cd /tmp;                           \
    sudo chown default: *.tar.gz;      \
    tar xvzf *.tar.gz; rm -f *.tar.gz; \
    cd guile*;                         \
    ./configure --prefix=/usr/local;   \
    make && make install;              \
    cd; rm -rf /tmp/guile*

RUN echo "(use-modules (ice-9 readline))\n(activate-readline)" > ~/.guile

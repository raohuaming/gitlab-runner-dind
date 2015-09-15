FROM gitlab/gitlab-runner:latest
MAINTAINER Huaming Rao <huaming.rao@gmail.com>

RUN apt-get update && apt-get install -y curl
RUN curl -sSL https://get.docker.com/ | sh

VOLUME /var/run/docker.sock

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

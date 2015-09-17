FROM tutum/dind:latest
MAINTAINER Huaming Rao <huaming.rao@gmail.com>

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y ca-certificates wget apt-transport-https vim nano

RUN echo "deb https://packages.gitlab.com/runner/gitlab-ci-multi-runner/ubuntu/ `lsb_release -cs` main" > /etc/apt/sources.list.d/runner_gitlab-ci-multi-runner.list && \
    wget -q -O - https://packages.gitlab.com/gpg.key | apt-key add - && \
    apt-get update -y && \
    apt-get install -y gitlab-ci-multi-runner

ADD entrypoint /
RUN chmod +x /entrypoint

ADD tutum-builder /usr/bin/
RUN chmod +x /usr/bin/tutum-builder

RUN echo "Cmnd_Alias TUTUM_BUILD = /usr/bin/tutum-builder *" >> /etc/sudoers
RUN echo "gitlab-runner ALL=NOPASSWD: TUTUM_BUILD" >> /etc/sudoers

VOLUME ["/etc/gitlab-runner", "/home/gitlab-runner"]
ENTRYPOINT ["/entrypoint"]
CMD ["run", "--user=gitlab-runner", "--working-directory=/home/gitlab-runner"]

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

FROM ubuntu:20.04

RUN sed -i 's:^path-exclude=/usr/share/man:#path-exclude=/usr/share/man:' \
        /etc/dpkg/dpkg.cfg.d/excludes

RUN  apt update && \
        apt install -y man man-db manpages-posix tmux sudo && \
        yes | unminimize && \
        mkdir -p /home/examples
COPY ./examples /home/examples
WORKDIR /home/examples
CMD exec /bin/sh -c "trap : TERM INT; sleep 1d & wait"
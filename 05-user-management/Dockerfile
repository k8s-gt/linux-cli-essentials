FROM ubuntu:20.04

RUN  apt update && \
        apt install -y tmux sudo && \
        mkdir -p /home/examples

WORKDIR /home/examples
CMD exec /bin/sh -c "trap : TERM INT; sleep 1d & wait"
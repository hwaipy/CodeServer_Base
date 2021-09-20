FROM ubuntu:18.04

RUN apt-get update

# Install tools
RUN apt-get install -y nano 
RUN apt-get install -y curl
RUN apt-get install -y ca-certificates

# Install CodeServer
RUN curl -fsSL https://code-server.dev/install.sh | sh -s -- --dry-run
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Install Git
RUN apt-get install git -y

RUN mkdir /home/workspace

# Set WORKPATH
ENV WORKPATH=/home/workspace/

RUN git init && \
    git config --global user.email "hwaipy@gmail.com" && \
    git config --global user.name "Hwaipy" && \
    git config credential.helper store

EXPOSE 8080

ENTRYPOINT code-server --bind-addr 0.0.0.0:8080 --auth password --cert=/root/.config/OpenSSL/server.crt --cert-key=/root/.config/OpenSSL/server.key $WORKPATH
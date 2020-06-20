# Container image that runs your code
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive 
ENV TZ=America/New_York

RUN apt-get update -y && \
	apt-get upgrade -y

RUN apt-get install -y \
    build-essential \
    libconfig-dev \
    libtool \
    autotools-dev \
    automake \
    lsb-release \
    apt-transport-https \
    software-properties-common \
    pkg-config

RUN apt-get install -y \
    sudo \
    make \
    git \
    cmake \
    python3 \
    wget \
    curl \
    parallel

RUN wget https://apt.llvm.org/llvm.sh && \
    chmod +x llvm.sh && \
	./llvm.sh 10 

RUN apt-get install -y libsodium23 libsodium-dev 
RUN apt-get install -y yasm flex bison

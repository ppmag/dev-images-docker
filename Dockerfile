FROM ubuntu:20.04

SHELL ["/bin/bash", "-c"]
 
ENV DEBIAN_FRONTEND=noninteractive 
ENV TZ=America/New_York

RUN apt-get update -y && \
	apt-get upgrade -y
	
RUN apt-get update -y && \	
	apt-get dist-upgrade -y

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
    zip \
    git \
    cmake \
    python2.7 \
    python3 \
    python3-distutils \
    wget \
    curl \
    parallel

RUN ln -s /usr/bin/python2.7 /usr/bin/python

RUN wget https://apt.llvm.org/llvm.sh && \
    chmod +x llvm.sh && \
    ./llvm.sh 10

# C++ dependencies
RUN apt-get install -y libsodium23 libsodium-dev \
    yasm flex bison gawk 

####################################################
# Next components are required for wasm testing only

# reqired by Emscripten's Closure Compiler
RUN apt-get install -y default-jre 

# WebAssembly related
RUN cd /root && \ 
    git clone https://github.com/emscripten-core/emsdk.git && \
	cd emsdk && \
	./emsdk install 1.39.5 && \
	./emsdk activate 1.39.5
	 
# Build Libsodium for Wasm
RUN cd /root && \
    git clone https://github.com/jedisct1/libsodium --branch stable && \
    cd libsodium && \
    source ../emsdk/emsdk_env.sh && \
    source ./dist-build/emscripten.sh --standard
 
# Install latest Chrome
RUN curl -LO https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    apt-get install -y ./google-chrome-stable_current_amd64.deb && \
    rm google-chrome-stable_current_amd64.deb

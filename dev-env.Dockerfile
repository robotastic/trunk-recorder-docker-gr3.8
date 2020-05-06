FROM ubuntu:20.04 AS base

RUN apt-get update && \
  apt-get -y upgrade &&\
  # set noninteractive installation
  export DEBIAN_FRONTEND=noninteractive && \
  #install tzdata package
  apt-get install -y tzdata &&\
  # set your timezone
  ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime && \
  dpkg-reconfigure --frontend noninteractive tzdata && \
  apt-get install -y gnuradio gnuradio-dev gr-osmosdr libhackrf-dev libuhd-dev libgmp-dev && \
  apt-get install -y git cmake build-essential pkg-config libboost-all-dev libusb-1.0-0.dev libssl-dev libcurl4-openssl-dev liborc-0.4-dev && \
  apt-get install -y ca-certificates expat libgomp1 fdkaac sox && \
  apt-get install -y git htop man unzip nano wget && \
  rm -rf /var/lib/apt/lists/*

ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  
CMD ["/bin/bash"]

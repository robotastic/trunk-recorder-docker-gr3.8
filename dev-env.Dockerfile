FROM ubuntu:18.04

COPY 99gnuradio-release /etc/apt/preferences.d/

RUN \
  apt-get update && \
  apt-get -y upgrade &&\
  # set noninteractive installation
  export DEBIAN_FRONTEND=noninteractive && \
  #install tzdata package
  apt-get install -y tzdata &&\
  # set your timezone
  ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime && \
  dpkg-reconfigure --frontend noninteractive tzdata && \
  apt-get install -y build-essential software-properties-common&& \
  apt-get install -y git htop man unzip nano wget && \
  add-apt-repository ppa:gnuradio/gnuradio-releases && \
  wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | apt-key add - && \
  apt-add-repository 'deb https://apt.kitware.com/ubuntu/ bionic main' && \
  apt-get update && \
  apt-get install -y gnuradio libgmp-dev && \
  apt-get install -y libhackrf-dev libuhd-dev && \
  apt-get install -y git cmake build-essential libboost-all-dev libusb-1.0-0.dev libssl-dev && \
  rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/osmocom/gr-osmosdr/tree/gr3.8 
COPY 99gnuradio-release /etc/apt/preferences.d/
RUN    cd gr-osmosdr && \
    mkdir build && cd build && cmake ../ && make && make install 
RUN ln -s /usr/lib/x86_64-linux-gnu/liborc-0.4.so.0.28.0 /usr/lib/x86_64-linux-gnu/liborc-0.4.so 
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  
CMD ["/bin/bash"]
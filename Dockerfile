FROM ubuntu:latest
MAINTAINER Theeraphol Wattanavekin <parnurzeal@gmail.com>
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y g++ make curl python gcc automake apt-utils
RUN echo 'alias g++="g++ --std=c++0x"' >>~/.bashrc
RUN . ~/.bashrc 
RUN curl -SL http://www.openfst.org/twiki/pub/FST/FstDownload/openfst-1.6.9.tar.gz \
    | tar -xzC /root/
WORKDIR /root/openfst-1.6.9
RUN ./configure \
        --enable-static=yes \
        --enable-far 
RUN make && make install
RUN curl -SL http://www.openfst.org/twiki/pub/GRM/ThraxDownload/thrax-1.2.7.tar.gz \
    | tar -xzC /root/
WORKDIR /root/thrax-1.2.7
RUN ./configure
RUN make && make install
ENV LD_LIBRARY_PATH /usr/local/lib
COPY src/ ./src
WORKDIR ./src
RUN make

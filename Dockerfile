FROM ubuntu:16.04

RUN apt-get update
RUN apt-get -y install git
RUN apt-get -y install texlive-full
